using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using FlightDetailsModelLibrary;
using User_Reg_BL_Library;
using System.Web.Http.Cors;


namespace FlightBookingWepApiProject.Controllers
{
    
    [EnableCors("http://localhost:4200", "*", "GET,PUT,POST")]
    public class AdminController : ApiController
    {
        static List<FlightDetailsModel> details = new List<FlightDetailsModel>();
        RegBL bl;
        // GET: api/Admin
        public AdminController()
        {
            bl = new RegBL();

        }
        [HttpGet]
        [Authorize(Roles = "Admin")]
        [Route("api/admin/getdetails")]

        public IEnumerable<FlightDetailsModel> getdetails(int uid)
        {

            details = bl.GetFlightDetails(uid);
            if(details.Count==0)
            {
                return details = null;
            }
            else
            {
                return details;
            }
        }

        // GET: api/Admin/5
        //public IEnumerable<FlightDetailsModel> Get()
        //{
        //    // return "value";


        //}

        // POST: api/Admin
        [HttpPost]
        [Authorize(Roles = "Admin")]
        [Route("api/admin/adddetails")]

        public bool Post([FromBody]FlightDetailsModel value)
        {
            string s = "";
            string s2 = "D0";

            int n = value.Dateid.Length;
            s = value.Dateid.Substring(8, 2);
            s = s2 + s;
            try {
                return bl.Insert(value.Ft_id, value.Source_id, value.Destination_id, value.Departure, value.Arrival, s, value.Duration, value.Fare);
            }
            catch(Exception e)
            {
                return false;
            }

        }

        // PUT: api/Admin/5
        [HttpPut]
        [Authorize(Roles = "Admin")]
        [Route("api/admin/updatedetails")]

        public bool updatedetails(string id, [FromBody]FlightDetailsModel flight)
        {
            bool s = false;
            var user = (from u in details
                        where u.Fd_id == id
                        select u).First();

            if (bl.UpdateDetail(id, flight))
                s = true;
            else
                s = false;
            return s;



        }
        
        // DELETE: api/Admin/5
        [HttpDelete]
        [Authorize(Roles = "Admin")]
        [Route("api/admin/deletedetails")]
        public bool deletedetails(string  flightid)
        {
            try
            {
             return bl.DeletingFlight(flightid);

            }
            catch(Exception e)
            {
                return false;
            }
        }
    }
}
