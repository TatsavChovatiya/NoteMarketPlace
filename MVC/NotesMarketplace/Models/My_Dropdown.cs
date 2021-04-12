using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class My_Dropdown
    {
        public NotesMarketplaceEntities db = null;
        public List<ManageCTC> myctc = null;
        public List<String> types, categories, countries, universities, courses;
        public My_Dropdown()
        {
            db = new NotesMarketplaceEntities();
            myctc = db.ManageCTCs.ToList();

            types = myctc.Where(m => m.CTC.P_K_CTC == 2).Select(m => m.Value.ToLower()).Distinct().ToList();
            categories = myctc.Where(m => m.CTC.P_K_CTC == 1).Select(m => m.Value.ToLower()).Distinct().ToList();
            universities = db.NotesDetails.Where(m => m.InstitutionName != null).Select(m => m.InstitutionName.ToLower()).Distinct().ToList();
            courses = db.NotesDetails.Where(m => m.Course != null).Select(m => m.Course.ToLower()).Distinct().ToList();
            countries = myctc.Where(m => m.CTC.P_K_CTC == 3).Select(m => m.Value.ToLower()).Distinct().ToList();
        }

    }
}