using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class SearchPageModel
    {
        public PagedList.IPagedList<My_Search> mysearch { get; set; }
        public My_Dropdown my_Dropdown { get; set; }
        public int count { get; set; }
    }
}