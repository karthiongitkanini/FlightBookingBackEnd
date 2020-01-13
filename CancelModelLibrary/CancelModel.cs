using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CancelModelLibrary
{
    public class CancelModel
    {
        string ps_Id, ps_Name, ps_Age, ps_Gender, user_Id;

        public string Ps_Id { get => ps_Id; set => ps_Id = value; }
        public string Ps_Name { get => ps_Name; set => ps_Name = value; }
        public string Ps_Age { get => ps_Age; set => ps_Age = value; }
        public string Ps_Gender { get => ps_Gender; set => ps_Gender = value; }
        public string User_Id { get => user_Id; set => user_Id = value; }
    }
}
