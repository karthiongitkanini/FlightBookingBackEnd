using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;
using User_Reg_BL_Library;
using BookingDetailsLibrary;

namespace FlightBookingWepApiProject.Controllers
{
    [EnableCors("http://localhost:4200", "*", "GET,PUT,POST")]

    public class BookingDetailsController : ApiController
    {
        RegBL bl = new RegBL();
        static List<BookingDetailsModel> bookingDetails = new List<BookingDetailsModel>();
        // GET: api/BookingDetails
        public IEnumerable<BookingDetailsModel> Get(string Username)
        {
            try
            {
                return bl.GetAllbookedDetails(Username);

            }
            catch (Exception)
            {

                return bookingDetails = null;
            }
        }

        // GET: api/BookingDetails/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/BookingDetails
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/BookingDetails/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/BookingDetails/5
        public void Delete(int id)
        {
        }
    }
}
