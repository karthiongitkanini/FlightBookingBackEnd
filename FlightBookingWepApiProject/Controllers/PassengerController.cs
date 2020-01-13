using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using User_Reg_BL_Library;
using PassengerModelLibrary;
using System.Web.Http.Cors;

namespace FlightBookingWepApiProject.Controllers
{
    [EnableCors("http://localhost:4200", "*", "GET,PUT,POST")]
    public class PassengerController : ApiController
    {
        // GET: api/Passenger
        RegBL bl = new RegBL();
        List<string> flightIds = new List<string>();
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }
        [AllowAnonymous]
        // GET: api/Passenger/5
        public List<string> Get(string doj, string source, string destination)
        {
            flightIds = bl.FetchFlightId(doj, source, destination);
            return flightIds;
        }

        // POST: api/Passenger
        public bool Post([FromBody]PassengerModel[] value)
        {
            //var passenger = (from p in passengers
            //                 select p).First();
            try
            {
                if (value != null)
                {
                    foreach (var item in value)
                    {
                        bl.Insert_Passenger(item);
                    }
                    return true;
                }
                else
                    return false;

            }
            catch (Exception)
            {

                return false;
            }
        }

        // PUT: api/Passenger/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Passenger/5
        public void Delete(int id)
        {
        }
    }
}
