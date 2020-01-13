using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using User_Reg_BL_Library;
using System.Web.Http;
using PreviewModelLibrary;

namespace FlightBookingWepApiProject.Controllers
{
    public class PreviewController : ApiController
    {
        RegBL bl = new RegBL();
        static List<PreviewDetailsModel> passengers = new List<PreviewDetailsModel>();
        // GET: api/Preview
        public IEnumerable<PreviewDetailsModel> Get()
        {
            try
            {
                return bl.PrintPreviewDetails();
            }
            catch (Exception)
            {
                return passengers = null;
            }
        }

        // GET: api/Preview/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/Preview
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/Preview/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Preview/5
        public void Delete(int id)
        {
        }
    }
}
