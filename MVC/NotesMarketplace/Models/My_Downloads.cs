using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace NotesMarketplace.Models
{
    public class My_Downloads
    {
        public PagedList.IPagedList<DownloadRequests> downloadRequests {get; set;}
        public SpamReport spamReport { get; set; }
        public Feedback feedback { get; set; }
    }
}