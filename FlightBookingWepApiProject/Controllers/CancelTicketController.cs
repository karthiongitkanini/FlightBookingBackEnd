using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;
using CancelTicketModelLibrary;
using User_Reg_BL_Library;

namespace FlightBookingWepApiProject.Controllers
{
    [EnableCors("http://localhost:4200", "*", "GET,POST,PUT,DELETE")]
    public class CancelTicketController : ApiController
    {
        RegBL bl = new RegBL();
        static List<TicketModel> bookingDetails = new List<TicketModel>();
        // GET: api/CancelTicket
        public IEnumerable<TicketModel> Get(string Username)
        {
            return bl.GetAllbookedDetailss(Username);
        }
        // GET: api/CancelTicket/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/CancelTicket
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/CancelTicket/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/CancelTicket/5
        public void Delete(int id)
        {
        }
    }
}
