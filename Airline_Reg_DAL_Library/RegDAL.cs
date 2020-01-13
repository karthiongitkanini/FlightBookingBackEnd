using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using SearchFlightModelLibrary;
using PassengerModelLibrary;
using FlightDetailsModelLibrary;
using PreviewModelLibrary;
using CancelModelLibrary;
using BookingDetailsLibrary;
using CancelTicketModelLibrary;

namespace Airline_Reg_DAL_Library
{
    public class RegDAL
    {
        SqlConnection conn;
        SqlCommand  cmdFetchFlightDetails, cmdFetchCityName, cmdFetchPassword, cmdFetchFlightids,cmdInsertUser, cmdFetchPassenger, cmdFetchPrice, cmdInsertPayUser, cmdDeletePassenger,
            cmdAddPassager, cmdInsertflight,cmdUpdatePass, cmdDeleteFlightDetails, cmdFetchDetails, cmdFetchBookingDetails,cmd;
        public RegDAL()
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conFlight"].ConnectionString);
        }

        public string FetchPassword(string email)
        {
            cmdFetchPassword = new SqlCommand("Proc_UserLogin", conn);
            cmdFetchPassword.Parameters.Add("@email", SqlDbType.VarChar, 20);
            cmdFetchPassword.Parameters.Add("@password", SqlDbType.VarChar, 20);
            cmdFetchPassword.CommandType = CommandType.StoredProcedure;
            string password = null;

            conn.Open();

            cmdFetchPassword.Parameters[0].Value = email;
            cmdFetchPassword.Parameters[1].Direction = ParameterDirection.Output;
            cmdFetchPassword.ExecuteNonQuery();
            password = cmdFetchPassword.Parameters[1].Value.ToString();
            conn.Close();
            return password;

        }
        public bool CheckUser(string username)
        {
            bool val = false;
            cmdFetchPassword = new SqlCommand("Proc_UserLogin", conn);
            cmdFetchPassword.Parameters.Add("@email", SqlDbType.VarChar, 20);
            cmdFetchPassword.Parameters.Add("@password", SqlDbType.VarChar, 20);
            cmdFetchPassword.CommandType = CommandType.StoredProcedure;
            string password = null;

            conn.Open();

            cmdFetchPassword.Parameters[0].Value = username;
            cmdFetchPassword.Parameters[1].Direction = ParameterDirection.Output;
            cmdFetchPassword.ExecuteNonQuery();
            password = cmdFetchPassword.Parameters[1].Value.ToString();
            try
            {
                if (password != null && username!=null)
                {
                    val = true;
                }
            }
            catch (Exception)
            {

                val = false;
            }

             
            conn.Close();
            return val;
             

        }
        public List<SearchFlight> GetFlightDetails(string fldate, string source, string destination)
        {
            List<SearchFlight> details = new List<SearchFlight>();
            conn.Open();
            cmdFetchFlightDetails = new SqlCommand("proc_SearchFlight", conn);
            cmdFetchFlightDetails.Parameters.Add("@date", SqlDbType.VarChar, 10);
            cmdFetchFlightDetails.Parameters.Add("@source", SqlDbType.VarChar, 20);
            cmdFetchFlightDetails.Parameters.Add("@destination", SqlDbType.VarChar, 20);
            cmdFetchFlightDetails.CommandType = CommandType.StoredProcedure;
            cmdFetchFlightDetails.Parameters[0].Value = fldate;
            cmdFetchFlightDetails.Parameters[1].Value = source;
            cmdFetchFlightDetails.Parameters[2].Value = destination;
            SqlDataReader drFlightDetails = cmdFetchFlightDetails.ExecuteReader();
            SearchFlight search = null;
            //if (drFlightDetails.HasRows == false)
               //throw new NoFlightInDatabaseException();
            while (drFlightDetails.Read())
            {
                search = new SearchFlight();
                search.Flightid = drFlightDetails[0].ToString();
                search.Departuretime = drFlightDetails[1].ToString();
                search.Arrivaltime = drFlightDetails[2].ToString();
                search.Duration = drFlightDetails[3].ToString();
                search.Fare = drFlightDetails[4].ToString();
                details.Add(search);
            }
            return details;

        }

        public List<string> FetchCityName()
        {
            List<string> cityName = new List<string>();
            cmdFetchCityName = new SqlCommand("proc_FetchCityName", conn);
            conn.Open();
            SqlDataReader drCityName = cmdFetchCityName.ExecuteReader();
            while (drCityName.Read())
            {
                cityName.Add(drCityName[0].ToString());
            }
            conn.Close();
            return cityName;
        }


        public bool Insert_user(string ufname, string ulname,  string pnum, string gmail, string password)
        {
            bool return_value = false;
            try
            {
                cmdInsertUser = new SqlCommand("Insert_User_data", conn);
                cmdInsertUser.Parameters.Add("@ufname", SqlDbType.VarChar, 20);
                cmdInsertUser.Parameters.Add("@ulname", SqlDbType.VarChar, 20);
                cmdInsertUser.Parameters.Add("@pnumber", SqlDbType.VarChar, 20);
                cmdInsertUser.Parameters.Add("@gmail", SqlDbType.VarChar, 20);
                cmdInsertUser.Parameters.Add("@password", SqlDbType.VarChar, 20);
                cmdInsertUser.CommandType = CommandType.StoredProcedure;
                conn.Open();
                cmdInsertUser.Parameters[0].Value = ufname;
                cmdInsertUser.Parameters[1].Value = ulname;
                cmdInsertUser.Parameters[2].Value = pnum;
                cmdInsertUser.Parameters[3].Value = gmail;
                cmdInsertUser.Parameters[4].Value = password;
                if (cmdInsertUser.ExecuteNonQuery() > 0)
                {
                    return_value = true;

                }
            }
            catch (Exception)
            {
                return_value = false;
            }
            conn.Close();
            return return_value;
        }
        public bool Add_Passanger(PassengerModel p)
        {
            bool return_value = false;
            cmdAddPassager = new SqlCommand("Insert_Passenger", conn);

            cmdAddPassager.Parameters.Add("@Ps_Name", SqlDbType.VarChar, 20);
            cmdAddPassager.Parameters.Add("@Ps_Age", SqlDbType.VarChar, 2);
            cmdAddPassager.Parameters.Add("@Ps_gender", SqlDbType.VarChar, 20);
            cmdAddPassager.CommandType = CommandType.StoredProcedure;
            conn.Open();

            cmdAddPassager.Parameters[0].Value = p.Name;
            cmdAddPassager.Parameters[1].Value = p.Age;
            cmdAddPassager.Parameters[2].Value = p.Gender;
            if (cmdAddPassager.ExecuteNonQuery() > 0)
            {
                return_value = true;
            }
            conn.Close();
            return return_value;
        }
        public bool Insert_Flight(string FT_Id1, string startpt, string destination, string dprttym, string arrvltym, string date, string duration, string fare)
        {
            bool return_value = false;

            cmdInsertflight = new SqlCommand("proc_InsertFlight", conn);
            cmdInsertflight.Parameters.Add("@FT_Id", SqlDbType.VarChar, 6);
            cmdInsertflight.Parameters.Add("@startpt", SqlDbType.VarChar, 20);
            cmdInsertflight.Parameters.Add("@destination", SqlDbType.VarChar, 20);
            cmdInsertflight.Parameters.Add("@dprttym", SqlDbType.VarChar, 20);
            cmdInsertflight.Parameters.Add("@arrvltym", SqlDbType.VarChar, 20);
            cmdInsertflight.Parameters.Add("@date", SqlDbType.VarChar, 20);
            cmdInsertflight.Parameters.Add("@duration", SqlDbType.VarChar, 20);
            cmdInsertflight.Parameters.Add("@fare", SqlDbType.VarChar, 20);

            cmdInsertflight.CommandType = CommandType.StoredProcedure;
            conn.Open();
            cmdInsertflight.Parameters[0].Value = FT_Id1;
            cmdInsertflight.Parameters[1].Value = startpt;
            cmdInsertflight.Parameters[2].Value = destination;
            cmdInsertflight.Parameters[3].Value = dprttym;
            cmdInsertflight.Parameters[4].Value = arrvltym;
            cmdInsertflight.Parameters[5].Value = date;
            cmdInsertflight.Parameters[6].Value = duration;
            cmdInsertflight.Parameters[7].Value = fare;
            if (cmdInsertflight.ExecuteNonQuery() > 0)
            {
                return_value = true;
            }
            conn.Close();
            return return_value;
        }


        public bool update_detail(string id,FlightDetailsModel fl)
        {
            bool updatestatus = false;
            cmdUpdatePass = new SqlCommand("proc_updateflightdetails", conn);
            cmdUpdatePass.CommandType = CommandType.StoredProcedure;
            cmdUpdatePass.Parameters.AddWithValue("@fd_id", id);
            cmdUpdatePass.Parameters.AddWithValue("@dep_time", fl.Departure);
            cmdUpdatePass.Parameters.AddWithValue("@arr_time", fl.Arrival);
            cmdUpdatePass.Parameters.AddWithValue("@date_id",fl.Dateid);
            cmdUpdatePass.Parameters.AddWithValue("@duration", fl.Duration);
            cmdUpdatePass.Parameters.AddWithValue("@fare", fl.Fare);
            conn.Open();
            if ((cmdUpdatePass.ExecuteNonQuery() > 0))
                updatestatus = true;
            return updatestatus;
        }
        public bool Delete(string FD_Id)
        {
            bool return_value = false;

            cmdDeleteFlightDetails = new SqlCommand("proc_Delete", conn);
            cmdDeleteFlightDetails.Parameters.Add("@fd_id", SqlDbType.Int);
            cmdDeleteFlightDetails.CommandType = CommandType.StoredProcedure;
            conn.Open();
            cmdDeleteFlightDetails.Parameters[0].Value = FD_Id;
            if (cmdDeleteFlightDetails.ExecuteNonQuery() > 0)
            {
                return_value = true;
            }
            conn.Close();
            return return_value;
        }
        public List<FlightDetailsModel> getAllDetails(int fid)
        {
            cmdFetchDetails = new SqlCommand("proc_flightDetails", conn);
            cmdFetchDetails.Parameters.Add("@fd_id", SqlDbType.Int);
            cmdFetchDetails.CommandType = CommandType.StoredProcedure;
            List<FlightDetailsModel> details = new List<FlightDetailsModel>();
            conn.Open();
            cmdFetchDetails.Parameters[0].Value = fid;
            SqlDataReader drUsers = cmdFetchDetails.ExecuteReader();
            FlightDetailsModel detail = null;
            while (drUsers.Read())
            {
                detail = new FlightDetailsModel();

                detail.Fd_id = drUsers[0].ToString();
                detail.Ft_id = drUsers[1].ToString();
                detail.Source_id = drUsers[2].ToString();
                detail.Destination_id = drUsers[3].ToString();
                detail.Departure = drUsers[4].ToString();
                detail.Arrival = drUsers[5].ToString();
                detail.Dateid = drUsers[6].ToString();
                detail.Duration = drUsers[7].ToString();
                detail.Fare = drUsers[8].ToString();
                details.Add(detail);
            }
            conn.Close();
            return details;

        }

        public List<PreviewDetailsModel> GetPreviewDetails()
        {
            List<PreviewDetailsModel> users = new List<PreviewDetailsModel>();
            OpenConnection();
            cmdFetchBookingDetails = new SqlCommand("proc_refDetails", conn);
            cmdFetchBookingDetails.CommandType = CommandType.StoredProcedure;
            SqlDataReader drUsers = cmdFetchBookingDetails.ExecuteReader();
            PreviewDetailsModel user = null;
            while (drUsers.Read())
            {
                user = new PreviewDetailsModel();
                user.S_Id = drUsers[0].ToString();
                user.Des_Id = drUsers[1].ToString();
                user.Departure_Time = drUsers[2].ToString();
                user.Arrival_Time = drUsers[3].ToString();
                user.Passenger = drUsers[4].ToString();
                user.Booked_Date = drUsers[5].ToString();
                user.Fare = drUsers[6].ToString();

                users.Add(user);
            }
            conn.Close();
            return users;
        }
        public bool Post(int flight, string us)
        {

            bool choice=false;
            cmd = new SqlCommand("proc_bookingflight", conn);
            cmd.Parameters.Add("@flightid", SqlDbType.Int);
            cmd.Parameters.Add("@username", SqlDbType.VarChar,20);
            cmd.CommandType = CommandType.StoredProcedure;
            OpenConnection();
            cmd.Parameters[0].Value = flight;
            cmd.Parameters[1].Value = us;
            if (cmd.ExecuteNonQuery() > 0)
            {
                choice = true;
            }
            conn.Close();
            return choice;


        }
        void OpenConnection()
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();
            conn.Open();

        }
        public List<CancelModel> GetAllPassengers(string User_Id)
        {
            List<CancelModel> passengers = new List<CancelModel>();
            cmdFetchPassenger = new SqlCommand("proc_fetchPassenger", conn);
            cmdFetchPassenger.Parameters.Add("@username", SqlDbType.Int);
            cmdFetchPassenger.CommandType = CommandType.StoredProcedure;
            OpenConnection();
            cmdFetchPassenger.Parameters[0].Value = Convert.ToInt32(User_Id);
            SqlDataReader drPass = cmdFetchPassenger.ExecuteReader();
            //if (drPass.HasRows == false)
            //    throw new NoUserInDatabaseException();
            CancelModel user = null;
            while (drPass.Read())
            {
                user = new CancelModel();
                user.Ps_Id = drPass[0].ToString();
                user.Ps_Name = drPass[1].ToString();
                user.Ps_Age = drPass[2].ToString();
                user.Ps_Gender = drPass[3].ToString();
                passengers.Add(user);
            }
            conn.Close();
            return passengers;
        }
       
        public bool DeletePassenger(string Ps_Id)
        {
            cmdDeletePassenger = new SqlCommand("proc_Delete_Passenger", conn);
            cmdDeletePassenger.Parameters.Add("@p_id", SqlDbType.Int);
            cmdDeletePassenger.CommandType = CommandType.StoredProcedure;
            OpenConnection();
            cmdDeletePassenger.Parameters[0].Value = Ps_Id;
            if (cmdDeletePassenger.ExecuteNonQuery() > 0)
            {
                conn.Close();
                return true;
            }
            else
            {
                conn.Close();
                return false;
            }
        }
        public bool Insert_PaymentDetails(string pay_type, string name_on_card, string card_number, string cexpiry_date, int cvv)
        {
            bool return_value = false;
            cmdInsertPayUser = new SqlCommand("proc_Insert_PaymentDetails", conn);
            cmdInsertPayUser.Parameters.Add("@pay_type", SqlDbType.VarChar, 15);
            cmdInsertPayUser.Parameters.Add("@name_on_card", SqlDbType.VarChar, 20);
            cmdInsertPayUser.Parameters.Add("@card_number", SqlDbType.VarChar, 20);
            cmdInsertPayUser.Parameters.Add("@cexpiry_date", SqlDbType.VarChar, 20);
            cmdInsertPayUser.Parameters.Add("@cvv", SqlDbType.Int);
            cmdInsertPayUser.CommandType = CommandType.StoredProcedure;
            conn.Open();
            cmdInsertPayUser.Parameters[0].Value = pay_type;
            cmdInsertPayUser.Parameters[1].Value = name_on_card;
            cmdInsertPayUser.Parameters[2].Value = card_number;
            cmdInsertPayUser.Parameters[3].Value = cexpiry_date;
            cmdInsertPayUser.Parameters[4].Value = cvv;
            //try
            //{
            if (cmdInsertPayUser.ExecuteNonQuery() > 0)
            {
                return_value = true;
            }
            // }
            //  catch(SqlException e)
            // {
            //     Console.WriteLine(e.Message);
            //  }
            conn.Close();
            return return_value;
        }

        public List<BookingDetailsModel> GetAllBookedDetails(string Username)
        {
            List<BookingDetailsModel> bookingDetails = new List<BookingDetailsModel>();
            cmdFetchPassenger = new SqlCommand("proc_bookingdetails", conn);
            cmdFetchPassenger.Parameters.Add("@username", SqlDbType.VarChar, 20);
            cmdFetchPassenger.CommandType = CommandType.StoredProcedure;
            OpenConnection();
            cmdFetchPassenger.Parameters[0].Value = Username;
            SqlDataReader drPass = cmdFetchPassenger.ExecuteReader();
            BookingDetailsModel user = null;
            while (drPass.Read())
            {
                user = new BookingDetailsModel();
                user.Pnr = drPass[0].ToString();
                user.TicketbookedOn = drPass[1].ToString();
                user.Bookeddate = drPass[2].ToString();
                user.Sid = drPass[3].ToString();
                user.Desid = drPass[4].ToString();
                user.Flightid = Convert.ToInt32(drPass[5]);
                user.Status = drPass[6].ToString();

                bookingDetails.Add(user);
            }
            conn.Close();
            return bookingDetails;
        }
        public List<TicketModel> GetAllBookedDetailss(string Username)
        {
            List<TicketModel> bookingDetails = new List<TicketModel>();
            cmdFetchPassenger = new SqlCommand("proc_cancelticketdetails", conn);
            cmdFetchPassenger.Parameters.Add("@username", SqlDbType.VarChar, 20);
            cmdFetchPassenger.CommandType = CommandType.StoredProcedure;
            OpenConnection();
            cmdFetchPassenger.Parameters[0].Value = Username;
            SqlDataReader drPass = cmdFetchPassenger.ExecuteReader();
            TicketModel user = null;
            while (drPass.Read())
            {
                user = new TicketModel();
                user.Pnr = drPass[0].ToString();
                user.Bookid = Convert.ToInt32(drPass[1]);
                user.TicketbookedOn = drPass[2].ToString();
                user.Bookeddate = drPass[3].ToString();
                user.Sid = drPass[4].ToString();
                user.Desid = drPass[5].ToString();
                user.Flightid = Convert.ToInt32(drPass[6]);
                user.Status = drPass[7].ToString();

                bookingDetails.Add(user);
            }
            conn.Close();
            return bookingDetails;
        }
        public string GetPrice(string date, string source, string destination, string temp)
        {
            string price = null;
            conn.Open();
            cmdFetchPrice = new SqlCommand("proc_FetchPrice", conn);
            cmdFetchPrice.Parameters.Add("@date", SqlDbType.VarChar, 20);
            cmdFetchPrice.Parameters.Add("@source", SqlDbType.VarChar, 20);
            cmdFetchPrice.Parameters.Add("@destination", SqlDbType.VarChar, 20);
            cmdFetchPrice.CommandType = CommandType.StoredProcedure;
            cmdFetchPrice.Parameters[0].Value = date;
            cmdFetchPrice.Parameters[1].Value = source;
            cmdFetchPrice.Parameters[2].Value = destination;

            SqlDataReader drprice = cmdFetchPrice.ExecuteReader();
            while (drprice.Read())
            {
                price = drprice[0].ToString();
            }
            return price;
        }

        public List<string> FetchFlightIds(string doj, string source, string destination)
        {
            cmdFetchFlightids = new SqlCommand("proc_FetchFlightIDs", conn);
            cmdFetchFlightids.Parameters.Add("@date", SqlDbType.VarChar, 20);
            cmdFetchFlightids.Parameters.Add("@source", SqlDbType.VarChar, 20);

            cmdFetchFlightids.Parameters.Add("@destination", SqlDbType.VarChar, 20);
            cmdFetchFlightids.CommandType = CommandType.StoredProcedure;

            List<string> flightIds = new List<string>();
            conn.Open();
            cmdFetchFlightids.Parameters[0].Value = doj;
            cmdFetchFlightids.Parameters[1].Value = source;
            cmdFetchFlightids.Parameters[2].Value = destination;
            SqlDataReader drIds = cmdFetchFlightids.ExecuteReader();
            while (drIds.Read())
            {
                flightIds.Add(drIds[0].ToString());

            }
            conn.Close();
            return flightIds;
        }

    }

}
