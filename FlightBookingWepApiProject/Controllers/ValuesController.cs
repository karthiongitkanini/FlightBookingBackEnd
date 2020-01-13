using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using User_Reg_BL_Library;
using System.Web.Http.Cors;


namespace FlightBookingWepApiProject.Controllers
{
    [EnableCors("http://localhost:4200/", "*", "GET,PUT,POST")]

    public class ValuesController : ApiController
    {
        // GET api/values
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/values/5
        [AllowAnonymous]

        public string Get(string date, string source, string destination, string temp)
        {
            RegBL bl = new RegBL();
            string price = bl.GetPrice(date, source, destination, temp);
            return price;
        }

        // POST api/values
        public void Post([FromBody]string value)
        {
        }

        // PUT api/values/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/values/5
        public void Delete(int id)
        {
        }
    }
}
