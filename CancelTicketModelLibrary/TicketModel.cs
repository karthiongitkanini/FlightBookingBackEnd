using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CancelTicketModelLibrary
{
    public class TicketModel
    {
        string bookeddate, sid, desid, username, status, pnr, ticketbookedOn;
        int flightid, bookid;

        public string Bookeddate { get => bookeddate; set => bookeddate = value; }
        public string Sid { get => sid; set => sid = value; }
        public string Desid { get => desid; set => desid = value; }
        public string Username { get => username; set => username = value; }
        public int Flightid { get => flightid; set => flightid = value; }
        public string Status { get => status; set => status = value; }
        public string Pnr { get => pnr; set => pnr = value; }
        public string TicketbookedOn { get => ticketbookedOn; set => ticketbookedOn = value; }
        public int Bookid { get => bookid; set => bookid = value; }
    }
}
