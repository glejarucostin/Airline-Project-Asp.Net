using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZedGraph;

namespace Proiect
{
    public partial class Grafic : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.ZedGraphWeb1.RenderGraph += ZedGraphWeb1_RenderGraph;
        }

        private void ZedGraphWeb1_RenderGraph(ZedGraph.Web.ZedGraphWeb webObject, System.Drawing.Graphics g, ZedGraph.MasterPane pane)
        {
            try
            {
                switch (Request.QueryString["type"])
                {
                    case "3":
                        {
                            bileteVandute(pane);
                            break;
                        }
                    case "2":
                        {
                            incasari(pane);
                            break;
                        }
                    case "1":
                        {
                            luni(pane);
                            break;
                        }
                }
            } catch (Exception ex)
            {

            }
        }

        private void luni(MasterPane pane)
        {
            DataTable data = (DataTable)Cache["luni"];
            GraphPane mpane = pane[0];
            mpane.Title.Text = "Evolutia vanzarilor de bilete pe luni pentru anul 2023.";
            mpane.XAxis.Title.Text = "Luna";
            mpane.YAxis.Title.Text = "Numar bilete vandute";
            ColorSymbolRotator rotator = new ColorSymbolRotator();
            if (Request.QueryString["type"] != null)
            {
                List<string> luni = new List<string>();
                luni.Add("Ian");
                luni.Add("Feb");
                luni.Add("Mar");
                luni.Add("Apr");
                luni.Add("Mai");
                luni.Add("Iun");
                luni.Add("Iul");
                luni.Add("Aug");
                luni.Add("Sep");
                luni.Add("Oct");
                luni.Add("Nov");
                luni.Add("Dec");
                PointPairList ppList = new PointPairList();
                List<int> bilete = new List<int>();
                for (int i= 0; i<12; i++)
                {
                    bilete.Add(0);
                }

               
                foreach (DataRow row in data.Rows)
                {
                    bilete[Convert.ToInt32(row[0]) - 1] = Convert.ToInt32(row[1]);
                }

                foreach (int elem in bilete)
                {
                    ppList.Add(0, elem);
                }

                LineItem curve = mpane.AddCurve("Numar bilete vandute", ppList, System.Drawing.Color.BlueViolet);
                curve.Line.IsSmooth = true;
                curve.Line.SmoothTension = 0.5F;
                curve.Line.Width = 2;

                curve.Symbol.Fill = new Fill(Color.White);
                curve.Symbol.Size = 10;
                mpane.XAxis.Scale.TextLabels = luni.ToArray();
                mpane.XAxis.Type = AxisType.Text;
            }
        }

        private void incasari(MasterPane pane)
        {
            DataTable data = (DataTable)Cache["incasari"];
            GraphPane mpane = pane[0];
            mpane.Title.Text = "Cota de piata a fiecarei companii aeriene.";
            ColorSymbolRotator rotator = new ColorSymbolRotator();
            Double total = 0;
            foreach (DataRow r in data.Rows)
            {
                total += Convert.ToDouble(r[1]);

            }
            if (Request.QueryString["type"] != null)
            {
               
                foreach (DataRow r in data.Rows)
                {
                    double procent = Convert.ToDouble(r[1]) / total;
                    PieItem segment1 = mpane.AddPieSlice(Convert.ToDouble(r[1]), ColorSymbolRotator.StaticNextColor, Color.White, 45f, 0, r[0].ToString() + ": " + r[1].ToString() + "$" + "\n\r" + procent.ToString("P", CultureInfo.InvariantCulture));
                  
                }
            }
        }

        private void bileteVandute(MasterPane pane)
        {
            DataTable data = (DataTable)Cache["numarBilete"];
            GraphPane mpane = pane[0];
            mpane.Title.Text = "Numarul de bilete vandute pentru fiecare zbor";
            mpane.XAxis.Title.Text = "Numar zbor";
            mpane.YAxis.Title.Text = "Numar bilete vandute";
            ColorSymbolRotator rotator = new ColorSymbolRotator();
            if (Request.QueryString["type"] != null)
            {
                List<string> numereZboruri = new List<string>();
                PointPairList ppList = new PointPairList();
                foreach (DataRow row in data.Rows)
                {
                    numereZboruri.Add(row[0].ToString());
                    ppList.Add(0, Convert.ToInt32(row[1]));
                }

                BarItem item = mpane.AddBar("Nr bilete", ppList, rotator.NextColor);
                item.Bar.Fill = new Fill(ColorSymbolRotator.StaticNextColor);
                item.Bar.Fill.Type = FillType.Solid;
                item.Bar.Fill.RangeMin = 0;
                item.Bar.Fill.RangeMin = ppList.Count;
                mpane.XAxis.Type = AxisType.Text;
                mpane.XAxis.Scale.TextLabels = numereZboruri.ToArray();
            }
        }
    }
}