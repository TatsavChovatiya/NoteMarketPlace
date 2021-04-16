using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class Member
    {
        public User user { get; set; }
        public int underreviewnotes { get; set; }
        public int publshednotes { get; set; }
        public int downloadednotes { get; set; }
        public int totalexpensis { get; set; }
        public int totalearning { get; set; }
    }
}