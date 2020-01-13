using FlightBookingWepApiProject.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System.Web.Http.Cors;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace FlightBookingWepApiProject.Controllers
{
    [EnableCors("http://localhost:4200", "*", "GET,PUT,POST")]
    public class AccountController : ApiController
    {
        [Route("api/User1/Register")]
        [HttpPost]
        [AllowAnonymous]
        public IdentityResult Register(RegModel registerModel)
        {
            var userStore = new UserStore<ApplicationUser>(new ApplicationDbContext());
            var manager = new UserManager<ApplicationUser>(userStore);
            var user = new ApplicationUser() { UserName = registerModel.Username, Lastname = registerModel.Lastname };

            user.Email = registerModel.Email;
            //user.Dob = registerModel.Dob;
            user.PhoneNumber = registerModel.Phonenumber;
            IdentityResult result = manager.Create(user, registerModel.Password);
            return result;
        }
    }
}
