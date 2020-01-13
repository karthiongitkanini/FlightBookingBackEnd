using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using PaymentLibraryModel;
using User_Reg_BL_Library;
using System.Web.Http.Cors;
namespace FlightBookingWepApiProject.Controllers
{
    [EnableCors("http://localhost:4200", "*", "GET,POST,PUT,DELETE")]
    public class PaymentController : ApiController
    {
        RegBL bl = new RegBL();
        // GET: api/Payment
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET: api/Payment/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/Payment
        public bool Post([FromBody]PaymentModel value)
        {
            string expiredate = value.Expirationmonth + "/" + value.Expirationyear;
            try
            {
                return bl.Insert_PaymentDetails(value.Paymenttype, value.Cardholder, value.Cardnumber, expiredate, value.Cvv);
            }
            catch(Exception e)
            {
                return false;
            }
        }

        // PUT: api/Payment/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Payment/5
        public void Delete(int id)
        {
        }
    }
}