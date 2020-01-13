using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PaymentLibraryModel
{
    public class PaymentModel
    {
        string cardholder, cardnumber, expirationmonth, expirationyear;
        int cvv;
        string paymenttype;


        public string Cardholder { get => cardholder; set => cardholder = value; }
        public string Cardnumber { get => cardnumber; set => cardnumber = value; }
        public string Expirationmonth { get => expirationmonth; set => expirationmonth = value; }
        public string Expirationyear { get => expirationyear; set => expirationyear = value; }
        public int Cvv { get => cvv; set => cvv = value; }
        public string Paymenttype { get => paymenttype; set => paymenttype = value; }

    }
}
