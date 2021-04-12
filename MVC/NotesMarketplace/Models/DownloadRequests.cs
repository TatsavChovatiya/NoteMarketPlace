using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class DownloadRequests
    {
        public DownloadedNote downloadedNote { get; set; }
        public String phonenumber { get; set; }
        public String emailid { get; set; }  
    }
}