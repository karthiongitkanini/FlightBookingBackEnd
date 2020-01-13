using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PreviewModelLibrary
{
    public class PreviewDetailsModel
    {

        string s_Id, des_Id, departure_Time, arrival_Time, passenger, fare, booked_Date;


        public string S_Id { get => s_Id; set => s_Id = value; }
        public string Des_Id { get => des_Id; set => des_Id = value; }
        public string Departure_Time { get => departure_Time; set => departure_Time = value; }
        public string Arrival_Time { get => arrival_Time; set => arrival_Time = value; }
        public string Booked_Date { get => booked_Date; set => booked_Date = value; }
        public string Fare { get => fare; set => fare = value; }
        public string Passenger { get => passenger; set => passenger = value; }

    }
}
