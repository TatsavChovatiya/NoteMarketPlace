using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class Dashboard_Admin
    {
        public NotesDetail notesDetail { get; set; }
        public int numberofdownload { get; set; }
        public String ApprovedBy { get; set; }
    }
}