﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SearchFlightModelLibrary
{
    public class SearchFlight
    {
        string flightid, arrivaltime, departuretime, duration, fare;
        int flight;
        string username;

        public string Flightid { get => flightid; set => flightid = value; }
        public string Arrivaltime { get => arrivaltime; set => arrivaltime = value; }
        public string Departuretime { get => departuretime; set => departuretime = value; }
        public string Duration { get => duration; set => duration = value; }
        public string Fare { get => fare; set => fare = value; }
        public int Flight { get => flight; set => flight = value; }
        public string Username { get => username; set => username = value; }
    }
}
