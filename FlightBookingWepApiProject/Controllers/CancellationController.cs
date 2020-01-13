using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using CancelModelLibrary;
using System.Web.Http.Cors;
using User_Reg_BL_Library;

namespace FlightBookingWepApiProject.Controllers
{
    [EnableCors("http://localhost:4200", "*", "GET,POST,PUT,DELETE")]
    public class CancellationController : ApiController
    {
        RegBL bl = new RegBL();
        static List<CancelModel> passengers = new List<CancelModel>();
        // GET: api/Cancellation
        public IEnumerable<CancelModel> Get(string User_Id)
        {
            try
            {
                return bl.GetAllPassengers(User_Id);
            }
            catch(Exception e)
            {
                return passengers = null;
            }
        }

        // GET: api/Cancellation/5
        //public void Get()
        //{

        //}

        // POST: api/Cancellation
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/Cancellation/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Cancellation/5
    
        public bool Delete(string Ps_Id)
        {
            bool deletestatus = false;
            string[] s = Ps_Id.Split(',');
            string sam = "";
            for (int i = 0; i < s.Length; i++)
            {

                sam = s[i].ToString();
                try
                {
                    deletestatus=bl.DeletePassenger(sam);
                }
                catch (Exception e)
                {
                    deletestatus = false;
                }
            }
            return deletestatus;
        }
    }
}
