using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proiect

{
    public partial class DataBinding : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LabelMessage2.Text = "";
            LabelMessage.Text = "";
            LabelNrBilete.Text = "";
            if(DropDownList1.Items.Count == 0)
            {
                populareDropDownCompanii();
            }
           
        }

       

        private void populareDropDownCompanii()
        {
            string constr = DSAeroportDestinatie.ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT Id, denumire FROM CompanieAeriana"))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        ListItem listItem = new ListItem();
                        listItem.Text = reader["denumire"].ToString();
                        listItem.Value = reader["Id"].ToString();
                        DropDownList1.Items.Add(listItem);
                    }

                    DropDownList1.DataBind();
                    con.Close();
                }
            }
        }

        protected void GVAeronave_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            LabelMessage.Text = "";
            try
            {
                if (e.NewValues["denumire"] != null &&
                   e.NewValues["denumire"].ToString().Trim().Length < 2)
                {
                    throw new Exception("Introduceti o denumire valida. Cel putin 2 litere.");
                }
                if (e.NewValues["nrLocuri"] != null &&
                   Convert.ToInt32(e.NewValues["nrLocuri"].ToString()) <= 0)
                {
                    throw new Exception("Introduceti numar locuri valid. Numar natural mai mare ca 0.");
                }

            }
            catch (Exception ex)
            {
                LabelMessage.Text = "Datele introduse nu au fost corecte: " + ex.Message;
                e.Cancel = true;

            }

        }

        protected void GVAeronave_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                
                LabelMessage.Text = "Datele introduse nu au fost corecte. " + e.Exception.Message.Substring(0, 100); ;
                e.ExceptionHandled = true;
                e.KeepInEditMode = true;

            }
        }

        protected void GVAeronave_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            LabelMessage.Text = "";

        }
        protected void GVZboruri_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            LabelMessage2.Text = "";
            try
            {
                if (e.NewValues["numar"] != null && e.NewValues["numar"].ToString().Trim().Length < 2)
                {
                    throw new Exception("Numar invalid.Trebuie sa aiba cel putin 2 caractere.");
                }
                if (e.NewValues["dataPlecare"] != null &&
                   Convert.ToDateTime(e.NewValues["dataPlecare"].ToString()) <= DateTime.Now)
                {
                    throw new Exception("Data invalida. Se poate introduce doar o data viitoare.");
                }
                if (e.NewValues["durata"] != null &&
                   Convert.ToDouble(e.NewValues["durata"].ToString()) <= 0)
                {
                    throw new Exception("Durata invalida. Durata trebuie sa fie nenula si pozitiva.");
                }
                if (e.NewValues["idAeroportPlecare"].Equals(e.NewValues["idAeroportSosire"]))
                {
                    throw new Exception("Aeroportul de sosire este acelasi cu cel de plecare");
                }

            }
            catch (Exception ex)
            {
                LabelMessage2.Text = "Datele introduse nu au fost corecte: " + ex.Message;
                e.Cancel = true;

            }
        }
        protected void GVZboruri_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {

            if (e.Exception != null)
            {
                LabelMessage2.Text = "Datele introduse nu au fost corecte: " + e.Exception.Message;
                e.ExceptionHandled = true;
                e.KeepInEditMode = true;

            }
        }

        protected void GVZboruri_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            LabelMessage2.Text = "";
        }

        protected void btnAeronaveInsert_Click(object sender, EventArgs e)
        {
            SqlConnection sqlConnection = new SqlConnection(DSAeroportDestinatie.ConnectionString);
            try
            {
                sqlConnection.Open();
                SqlCommand sqlCommand =
                    new SqlCommand("INSERT INTO Aeronava(denumire, nrLocuri, idCompanieAeriana) VALUES" +
                    "(@denumire, @nrLocuri, @idCompanieAeriana)", sqlConnection);
                TextBox txtDenumire = (TextBox)GVAeronave.FooterRow.FindControl("txtAeronavaDenumire");
                TextBox txtNrLocuri = (TextBox)GVAeronave.FooterRow.FindControl("txtAeronaveNrLocuri");
                DropDownList dropDownCompanieAeriana = (DropDownList)GVAeronave.FooterRow.FindControl("DropDownAeronaveCompanieAeriana");

                sqlCommand.Parameters.Add("denumire", System.Data.SqlDbType.NVarChar);
                sqlCommand.Parameters.Add("nrLocuri", System.Data.SqlDbType.Int);
                sqlCommand.Parameters.Add("idCompanieAeriana", System.Data.SqlDbType.Int);

                verifyDataInsertAeronave(txtDenumire.Text, txtNrLocuri.Text, dropDownCompanieAeriana.SelectedValue);

                sqlCommand.Parameters["denumire"].Value = txtDenumire.Text;
                sqlCommand.Parameters["nrLocuri"].Value = txtNrLocuri.Text;
                sqlCommand.Parameters["idCompanieAeriana"].Value = dropDownCompanieAeriana.SelectedValue;

                sqlCommand.ExecuteNonQuery();
                GVAeronave.DataBind();
            }
            catch (Exception ex)
            {
                LabelMessage.Text = "Datele introduse nu au fost corecte: " + ex.Message;
            }
            finally { sqlConnection.Close(); }

        }

        private void verifyDataInsertAeronave(string denumire, string nrLocuri, string companieAeriana)
        {
            LabelMessage.Text = "";
            if (denumire == null || denumire.Trim() == "" || denumire.Length < 2)
            {
                throw new Exception("Denumire invalida. Trebuie sa contina cel putin 2 caractere.");
            }
            if (nrLocuri == null || Convert.ToInt32(nrLocuri) <= 0)
            {
                throw new Exception("Numar locuri invalid. Trebuie sa fie un numar natural mai mare ca 0.");
            }

        }

        protected void btnZboruriInsert_Click(object sender, EventArgs e)
        {
            SqlConnection sqlConnection = new SqlConnection(DSAeroportDestinatie.ConnectionString);
            try
            {
                sqlConnection.Open();
                SqlCommand sqlCommand =
                    new SqlCommand("INSERT INTO Zbor(numar, dataPlecare, durata, idAeroportPlecare, idAeroportSosire, idAeronava, oraPlecare)" +
                    " VALUES" +
                    "(@numar, @dataPlecare, @durata, @idAeroportPlecare, @idAeroportSosire, @idAeronava, @oraPlecare)", sqlConnection);

                TextBox txtZborNumar = (TextBox)GVZboruri.FooterRow.FindControl("txtZborNumar");
                TextBox txtZborDataPlecare = (TextBox)GVZboruri.FooterRow.FindControl("txtZborDataPlecare");
                TextBox txtZborDurata = (TextBox)GVZboruri.FooterRow.FindControl("txtZborDurata");
                TextBox txtZborOraPlecare = (TextBox)GVZboruri.FooterRow.FindControl("txtZborOraPlecare");
                DropDownList ddZborAeroportPlecare = (DropDownList)GVZboruri.FooterRow.FindControl("ddZborAeroportPlecare");
                DropDownList ddZboruriAeroportSosire = (DropDownList)GVZboruri.FooterRow.FindControl("ddZboruriAeroportSosire");
                DropDownList ddZborAeronava = (DropDownList)GVZboruri.FooterRow.FindControl("ddZborAeronava");

                sqlCommand.Parameters.Add("numar", System.Data.SqlDbType.NVarChar);
                sqlCommand.Parameters.Add("dataPlecare", System.Data.SqlDbType.Date);
                sqlCommand.Parameters.Add("durata", System.Data.SqlDbType.Real);
                sqlCommand.Parameters.Add("idAeroportPlecare", System.Data.SqlDbType.Int);
                sqlCommand.Parameters.Add("idAeroportSosire", System.Data.SqlDbType.Int);
                sqlCommand.Parameters.Add("idAeronava", System.Data.SqlDbType.Int);
                sqlCommand.Parameters.Add("oraPlecare", System.Data.SqlDbType.Time);


                verifyDataInsertZboruri(txtZborNumar.Text, txtZborDataPlecare.Text, txtZborDurata.Text, ddZborAeroportPlecare.SelectedValue, ddZboruriAeroportSosire.SelectedValue);

                sqlCommand.Parameters["numar"].Value = txtZborNumar.Text;
                sqlCommand.Parameters["dataPlecare"].Value = txtZborDataPlecare.Text;
                sqlCommand.Parameters["durata"].Value = Convert.ToDouble(txtZborDurata.Text);
                sqlCommand.Parameters["idAeroportPlecare"].Value = ddZborAeroportPlecare.SelectedValue;
                sqlCommand.Parameters["idAeroportSosire"].Value = ddZboruriAeroportSosire.SelectedValue;
                sqlCommand.Parameters["idAeronava"].Value = ddZborAeronava.SelectedValue;
                sqlCommand.Parameters["oraPlecare"].Value = txtZborOraPlecare.Text;

                sqlCommand.ExecuteNonQuery();
                GVZboruri.DataBind();
            }
            catch (Exception ex)
            {
                LabelMessage2.Text = "Datele introduse nu au fost corecte: " + ex.Message;
            }
            finally { sqlConnection.Close(); }
        }

        private void verifyDataInsertZboruri(string numar, string dataPlecare, string durata, string aeroportPlecare, string aeroportSosire)
        {
            LabelMessage2.Text = "";
            if (numar == null ||
                   numar.Trim().Length < 2)
            {
                throw new Exception("Numar invalid.Trebuie sa aiba cel putin 2 caractere.");
            }
            if (dataPlecare == null ||
               Convert.ToDateTime(dataPlecare) <= DateTime.Now)
            {
                throw new Exception("Data invalida. Se pot adauga doar zboruri pentru o data viitoare.");
            }
            if (durata == null ||
               Convert.ToDouble(durata) <= 0)
            {
                throw new Exception("Durata invalida. Durata trebuie sa fie nenula si pozitiva.");
            }
            if (aeroportPlecare.Equals(aeroportSosire))
            {
                throw new Exception("Aeroportul de sosire este acelasi cu cel de plecare");
            }

        }

        protected void GVPasageri_SelectedIndexChanged(object sender, EventArgs e)
        {  
            try
                {

                    DataSourceSelectArguments args = new DataSourceSelectArguments();
                    SqlDataSourceZborPasager.SelectParameters["idPasager"].DefaultValue = GVPasageri.DataKeys[GVPasageri.SelectedRow.RowIndex]["Id"].ToString();
                    SqlDataSourceZborPasager.SelectParameters["business"].DefaultValue = CbBusiness.Checked.ToString();
                    SqlDataSourceZborPasager.Select(args);
                    DataView dataView = (DataView)SqlDataSourceZborPasager.Select(args);
                    DataTable table = dataView.ToTable();
                    DataSet ds = new DataSet();
                    ds.Tables.Add(table);
                    GridView4.DataSourceID = null;
                    GridView4.DataSource = ds;
                    GridView4.DataBind();

                }
                catch (Exception ex)
                {

                } 

        }

        protected void GridView6_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow selectedRow = GridView6.SelectedRow;
            LabelLocuriLibere.Text =
                "Pentru zborul " + selectedRow.Cells[2].Text + " sunt libere: ";
            try
            {
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter();
                SqlConnection connection = new SqlConnection(DSAeroportDestinatie.ConnectionString);
                connection.Open();
                String select = "SELECT a.nrLocuri - ISNULL(COUNT(b.idZbor),0) FROM Aeronava a, Bilet b, Zbor z " +
                    "WHERE a.Id = z.idAeronava AND z.Id = b.idZbor AND z.Id = @idZbor GROUP BY a.nrLocuri";
                select = "SELECT a.nrLocuri - ISNULL(COUNT(b.idZbor),0) FROM Zbor z " +
                    "JOIN Aeronava a ON a.Id = z.idAeronava LEFT OUTER JOIN Bilet b ON z.Id = b.idZbor " +
                    "WHERE z.Id = @idZbor GROUP BY a.nrLocuri";
                SqlCommand command = new SqlCommand(select, connection);
                command.Parameters.AddWithValue("@idZbor", GridView6.SelectedValue);
                sqlDataAdapter.SelectCommand = command;
                object result = sqlDataAdapter.SelectCommand.ExecuteScalar();
                if (result != null)
                {
                    LabelLocuriLibere.Text += result.ToString() + " locuri";
                }
                else
                {
                   
                    LabelLocuriLibere.Text = "Ne pare rau a aparut o eroare.";
                    connection.Close();
                }
            }
            catch (Exception ex)
            {
                LabelLocuriLibere.Text = "Ne pare rau a aparut o eroare.";

            }

        }

        protected void CbBusiness_CheckedChanged(object sender, EventArgs e)
        {
            GVPasageri.SelectedIndex = -1;
            GridView4.DataBind();
        }

        protected void btnCreareFunctie_Click(object sender, EventArgs e)
        {
            string sqlCreare =
                "CREATE FUNCTION incasari(@denumire NVARCHAR(50)) " +
                "RETURNS REAL AS BEGIN " +
                "DECLARE @incasari REAL " +
                "SELECT @incasari = SUM(b.pret) FROM Bilet b, Zbor z, Aeronava a, CompanieAeriana c " +
                "WHERE b.idZbor = z.Id AND z.idAeronava = a.Id AND a.idCompanieAeriana = c.Id AND c.denumire = @denumire " +
                "RETURN (CASE WHEN @incasari IS NULL THEN 0 ELSE @incasari END) END";

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ZboruriConnectionString"].ToString();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.Connection = connection;
                sqlCommand.CommandType = System.Data.CommandType.Text;
                try
                {
                    sqlCommand.CommandText = "DROP FUNCTION incasari";
                    sqlCommand.ExecuteNonQuery();
                }
                catch (Exception ex)
                {

                }
                try
                {
                    sqlCommand.CommandText = sqlCreare;
                    sqlCommand.ExecuteNonQuery();
                    Label20.Text = "Functie creata cu succes!";
                    btnApelFunctieIncasari.Enabled = true;
                }
                catch (Exception ex)
                {
                    Label20.Text = "Din pacate a aparut o eroare. Functia nu s-a creat";
                }

            }
        }

        protected void btnApelFunctieIncasari_Click(object sender, EventArgs e)
        {
            SqlConnection connection = new SqlConnection(DSAeroportDestinatie.ConnectionString);
            connection.Open();

            SqlCommand command = new SqlCommand("SELECT dbo.incasari(@denumire)", connection);
            command.CommandType = System.Data.CommandType.Text;
            command.Parameters.Add("@denumire", System.Data.SqlDbType.NVarChar);
            command.Parameters[0].Direction = System.Data.ParameterDirection.Input;
            command.Parameters[0].Value = tbDenumireCompanieAeriana.Text;

            object result = command.ExecuteScalar();
            if (result != null)
            {
               
                LabelIncasari.Text = "Incasarile companiei " + tbDenumireCompanieAeriana.Text + " sunt de " + result.ToString() + "$";
            } else
            {
                LabelIncasari.Text = "Compania nu exista.";

            }
            connection.Close();

        }

        protected void btnCreareProceduraDetaliiBilet_Click(object sender, EventArgs e)
        {
            string sqlCreare = "CREATE PROCEDURE detaliiBilet(@nume NVARCHAR(50), @prenume NVARCHAR(50), @numarBilete INT OUTPUT) " +
                "AS BEGIN SELECT z.numar, z.dataPlecare, z.durata, b.loc, b.pret, apl.denumire, aso.denumire " +
                "FROM Pasager p, Zbor z, Bilet b, Aeroport apl, Aeroport aso " +
                "WHERE b.idZbor = z.Id AND z.idAeroportPlecare = apl.Id AND z.idAeroportSosire = aso.Id AND p.Id = b.idPasager " +
                "AND p.nume = @nume AND p.prenume = @prenume; " +
                "SELECT @numarBilete = count(b.Id) FROM Bilet b, Pasager p WHERE p.Id = b.idPasager AND p.nume = @nume AND p.prenume = @prenume; END";
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ZboruriConnectionString"].ToString();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.Connection = connection;
                sqlCommand.CommandType = System.Data.CommandType.Text;
                try
                {
                    sqlCommand.CommandText = "DROP PROCEDURE detaliiBilet";
                    sqlCommand.ExecuteNonQuery();
                }
                catch (Exception ex)
                {

                }
                try
                {
                    sqlCommand.CommandText = sqlCreare;
                    sqlCommand.ExecuteNonQuery();
                    LabelProceduraDetaliiBilete.Text = "Procedura creata cu succes!";
                    btnApelProceduraDetaliiBilete.Enabled = true;
                }
                catch (Exception ex)
                {
                    LabelProceduraDetaliiBilete.Text = "Din pacate a aparut o eroare. Procedura nu s-a creat";
                }
            }
        }

        protected void btnApelProceduraDetaliiBilete_Click(object sender, EventArgs e)
        {
            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ZboruriConnectionString"].ToString();
                SqlConnection connection = new SqlConnection(connectionString);
                connection.Open();

                SqlCommand sqlCommand = new SqlCommand("detaliiBilet", connection);
                sqlCommand.CommandType = System.Data.CommandType.StoredProcedure;
                sqlCommand.Parameters.AddWithValue("nume", tbNume.Text);
                sqlCommand.Parameters[0].Direction = System.Data.ParameterDirection.Input;
                sqlCommand.Parameters.AddWithValue("prenume", tbPrenume.Text);
                sqlCommand.Parameters[1].Direction = System.Data.ParameterDirection.Input;
                sqlCommand.Parameters.Add("numarBilete", System.Data.SqlDbType.Int);
                sqlCommand.Parameters[2].Direction = System.Data.ParameterDirection.Output;

                sqlCommand.ExecuteNonQuery();
                if (sqlCommand.Parameters[2].Value != null)
                {
                    LabelNrBilete.Text = "Pasagerul a achizitionat " + sqlCommand.Parameters[2].Value.ToString() + " bilete.";

                }
                else
                {
                    LabelNrBilete.Text = "Pasagerul nu a achizitionat niciun bilet";
                }

                SqlDataReader reader = sqlCommand.ExecuteReader();

               

                while (reader.Read())
                {
                    TextBox8.Text += "\r\n" + reader[0].ToString() + " " + reader[1].ToString() + reader[2].ToString() + " "
                        + " " + reader[3].ToString() + " " + reader[4].ToString() + reader[5].ToString() + " " + reader[6].ToString();
                }

                reader.Close();

                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
                da.Fill(dt);
                GridView7.DataSource = dt;
                GridView7.DataBind();

                connection.Close();
            }
            catch (Exception ex)
            {
                LabelNrBilete.Text = "Procedura nu s-a executat, a aprut o eroare.";
            }

        }

        protected void btnCreareProceduraPret_Click(object sender, EventArgs e)
        {
            string sqlCreare = "CREATE PROCEDURE pretMaxim(@id INT OUTPUT) " +
                "AS BEGIN " +
                "DECLARE @maxim INT " +
                "SELECT @maxim = MAX(b.pret) FROM Zbor z, Bilet b " +
                "WHERE  z.Id = b.idZbor AND z.Id = @id " +
                "SELECT @id = (CASE WHEN @maxim IS NULL THEN 0 ELSE @maxim END) " +
                "END";
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ZboruriConnectionString"].ToString();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.Connection = connection;
                sqlCommand.CommandType = System.Data.CommandType.Text;
                try
                {
                    sqlCommand.CommandText = "DROP PROCEDURE pretMaxim";
                    sqlCommand.ExecuteNonQuery();
                }
                catch (Exception ex)
                {

                }
                try
                {
                    sqlCommand.CommandText = sqlCreare;
                    sqlCommand.ExecuteNonQuery();
                    LabelProceduraPret.Text = "Procedura creata cu succes!";
                    btnApelProceduraPret.Enabled = true;
                }
                catch (Exception ex)
                {
                    LabelProceduraPret.Text = "Din pacate a aparut o eroare. Procedura nu s-a creat";
                }
            }
        }

        protected void btnApelProceduraPret_Click(object sender, EventArgs e)
        {

            try
            {
                int id = convertireNumarLaId(tbNumarZbor.Text);
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ZboruriConnectionString"].ToString();
                SqlConnection connection = new SqlConnection(connectionString);
                connection.Open();

                SqlCommand sqlCommand = new SqlCommand("pretMaxim", connection);
                sqlCommand.CommandType = System.Data.CommandType.StoredProcedure;

                sqlCommand.Parameters.AddWithValue("id", id);
                sqlCommand.Parameters[0].Direction = System.Data.ParameterDirection.InputOutput;

                sqlCommand.ExecuteNonQuery();

                if (sqlCommand.Parameters[0].Value != null && Convert.ToInt16(sqlCommand.Parameters[0].Value) != 0)
                {
                    LabelPretMaxim.Text = "Pretul maxim este de " + sqlCommand.Parameters[0].Value.ToString() + " $.";

                }
                else
                {
                    LabelPretMaxim.Text = "Nu s-a vandut inca niciun bilet pentru zbor.";
                }
                connection.Close();
            }
            catch (Exception ex)
            {
                LabelPretMaxim.Text = "Din pacate a aparut o eroare. Verificati corectitudiea datelor introduse, zborul nu exista.";
            }
        }

        private int convertireNumarLaId(string numar)
        {
            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter();
            SqlConnection connection = new SqlConnection(DSAeroportDestinatie.ConnectionString);
            connection.Open();
            String select = "SELECT Id FROM Zbor WHERE numar = @numar";
            SqlCommand command = new SqlCommand(select, connection);
            command.Parameters.AddWithValue("@numar", numar);
            sqlDataAdapter.SelectCommand = command;
            int id = Convert.ToInt32(sqlDataAdapter.SelectCommand.ExecuteScalar());
            if (id != null && id != 0)
            {
                return id;
            }
            else
            {
                throw new Exception();
            }

        }

   

        protected void Button1_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            using (SqlConnection sqlConnection = new SqlConnection(DSAeroportDestinatie.ConnectionString))
            {
                string bare = "SELECT z.numar, ISNULL(COUNT(b.Id),0)FROM Zbor z " +
                    "LEFT OUTER JOIN Bilet b ON z.Id = b.idZbor " +
                    "GROUP BY z.numar";


                using (SqlDataAdapter adapter = new SqlDataAdapter(bare, sqlConnection))
                {
                    adapter.Fill(dt);
                    Cache["numarBilete"] = dt;
                    Response.Redirect("Grafic.aspx?type=" + "3");
                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            using (SqlConnection sqlConnection = new SqlConnection(DSAeroportDestinatie.ConnectionString))
            {
                string bare = "SELECT denumire, dbo.[incasari](denumire) FROM CompanieAeriana";


                using (SqlDataAdapter adapter = new SqlDataAdapter(bare, sqlConnection))
                {
                    adapter.Fill(dt);
                    Cache["incasari"] = dt;
                    Response.Redirect("Grafic.aspx?type=" + "2");
                }
            }


        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            using (SqlConnection sqlConnection = new SqlConnection(DSAeroportDestinatie.ConnectionString))
            {
                string bare = "SELECT MONTH(z.dataPlecare), ISNULL(COUNT(b.Id),0) FROM Zbor z " +
                    "LEFT OUTER JOIN Bilet b ON z.Id = b.idZbor " +
                    "WHERE YEAR(z.dataPlecare) = '2023' " +
                    "GROUP BY MONTH(z.dataPlecare)";


                using (SqlDataAdapter adapter = new SqlDataAdapter(bare, sqlConnection))
                {
                    adapter.Fill(dt);
                    Cache["luni"] = dt;
                    Response.Redirect("Grafic.aspx?type=" + "1");
                }
            }
        }

        protected void Label3_DataBinding(object sender, EventArgs e)
        {
            System.Web.UI.WebControls.Label label = (System.Web.UI.WebControls.Label)sender;
            label.Text = label.Text.ToString().Split(' ')[0];
        }
    }
    
}

