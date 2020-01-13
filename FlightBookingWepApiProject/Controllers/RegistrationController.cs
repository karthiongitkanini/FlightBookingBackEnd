using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using User_Reg_BL_Library;
using RegistrationModelLibrary;
using System.Web.Http.Cors;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using FlightBookingWepApiProject.Models;
using System.Security.Claims;
using System.Net.Mail;
using SearchFlightModelLibrary;
using FlightDetailsModelLibrary;

namespace FlightBookingWepApiProject.Controllers
{

    [EnableCors("http://localhost:4200/", "*", "GET,PUT,POST")]

    public class RegistrationController : ApiController
    {
        RegBL bl = new RegBL();
        static List<FlightDetailsModel> details = new List<FlightDetailsModel>();
        [Route("api/auth/Register")]
        [HttpPost]
        [AllowAnonymous]
        public IdentityResult Register(RegisterModel registerModel)
        {
            
            var userStore = new UserStore<ApplicationUser>(new ApplicationDbContext());
            var manager = new UserManager<ApplicationUser>(userStore);
            var user = new ApplicationUser() { UserName = registerModel.Username, Lastname = registerModel.Lastname,Firstname=registerModel.Firstname };

            user.Email = registerModel.Email;
            //user.Dob = registerModel.Dob;
            user.PhoneNumber = registerModel.Phonenumber;
            IdentityResult result = manager.Create(user, registerModel.Password);
            try
            {
                manager.AddToRoles(user.Id, registerModel.Roles);
                bl.Insert_userBl(registerModel.Firstname, registerModel.Lastname, registerModel.Phonenumber, registerModel.Username, registerModel.Password);


            }
            catch (Exception)
            {

             string   re = "username already exist";
                
            }
             return result;
        }
        [HttpGet]
        [Route("api/GetUserClaims")]
        [Authorize]
        public RegisterModel GetUserClaims()
        {
            var identityClaims = (ClaimsIdentity)User.Identity;
            IEnumerable<Claim> claims = identityClaims.Claims;
            RegisterModel model = new RegisterModel()
            {
                Username = identityClaims.FindFirst("username").Value,
                Lastname = identityClaims.FindFirst("Lastname").Value,
                Firstname=identityClaims.FindFirst("Firstname").Value,
              //  Email = identityClaims.FindFirst("Email").Value
            };
            return model;
        }

        [HttpGet]
        [Route("api/Check")]
        [AllowAnonymous]
        public bool Check(string umail)
        {
            string pass = bl.checkUser(umail);
            if (pass != null && pass != "")
            {
                MailMessage mm = new MailMessage();
                mm.From = new MailAddress("derillabi@gmail.com");
                mm.To.Add(umail);
                mm.Subject = "forgot password";
                mm.Body = "your old password is" + pass;
                SmtpClient smtp = new SmtpClient("smtp.gmail.com");
                smtp.UseDefaultCredentials = true;
                smtp.Port = 587;
                smtp.EnableSsl = true;
                smtp.Credentials = new System.Net.NetworkCredential("derillabi@gmail.com", "derilbihithdelbi12345");
                smtp.Send(mm);

                return true;
            }
            else
            {
                return false;
            }
        }
        [HttpGet]
        [Route("api/Getdetails")]
        [AllowAnonymous]
        public IEnumerable<string> Getdetails()
        {
            RegBL bl = new RegBL();
            List<string> list = new List<string>();
            list = bl.FetchPlaceNames();
            return list;
        }
        [HttpGet]
        [Route("api/Viewdetails")]
        [AllowAnonymous]
        public List<SearchFlight> Viewdetails(string date, string source, string destination)
        {
            RegBL bl = new RegBL();
            List<SearchFlight> list = new List<SearchFlight>();
            list = bl.getDetails(date, source, destination);
            return list;

        }
        //[HttpGet]
        //[Route("api/admin/getdetails")]
        //[AllowAnonymous]
        //public IEnumerable<FlightDetailsModel> getdetails(int uid)
        //{
        //    return details = bl.GetFlightDetails(uid);
        //}
        [Route("api/Register/ChangePassword")]
        [HttpPut]
        [AllowAnonymous]
        public IdentityResult ChangePassword(RegisterModel registerModel, string pass)
        {
            var userStore = new UserStore<ApplicationUser>(new ApplicationDbContext());
            var manager = new UserManager<ApplicationUser>(userStore);
            //var user = new ApplicationUser();
            var user = manager.FindByName(registerModel.Username);
            IdentityResult result = manager.ChangePassword(user.Id, registerModel.Password, pass);
            return result;
        }

        //[HttpGet]
        //[Authorize(Roles ="Admin")]
        //[Route("api/ForAdminRole")]
        //public string ForAdminRole()
        //{
        //    return "forAdminRole";
        //}
        //[HttpGet]
        //[Authorize(Roles = "User")]
        //[Route("api/ForUserRole")]
        //public string ForUserRole()
        //{
        //    return "forUserRole";
        //}



    }
}
