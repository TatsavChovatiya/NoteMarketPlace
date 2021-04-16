using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using PagedList;
using NotesMarketplace.Models;
using System.Net.Mail;
using System.Net;
using System.IO;
using NotesMarketplace.MyClass;

namespace NotesMarketplace.Controllers
{
    public class AdminController : Controller
    {
        private NotesMarketplaceEntities db = new NotesMarketplaceEntities();

        public ActionResult Dashboard(int? pageindex,String sort,String search,String month)
        {
            if (Register_id.id != 0)
            {
                User temp_user = db.Users.FirstOrDefault(m => m.P_K_User == Register_id.id);
                if (temp_user != null)
                {
                    if (temp_user.F_K_UserRoles == 3)
                    {
                        Register_id.issuperadmin = true;
                    }
                    var monthcriteria = DateTime.Now.AddMonths(-6);
                    List<NotesDetail> published_notes = db.NotesDetails.Where(m => m.IsActive && m.NotesStatu.P_K_NotesStatus == 4 && m.PublishedDate >= monthcriteria).OrderByDescending(m => m.PublishedDate).ToList();
                    if (!String.IsNullOrEmpty(month))
                    {
                        published_notes = published_notes.Where(m => m.PublishedDate.Value.ToString("Y").Equals(month)).ToList();
                    }
                    else
                    {
                        published_notes = published_notes.Where(m => m.PublishedDate.Value.ToString("Y").Equals(DateTime.Now.ToString("Y"))).ToList();
                    }
                    if (!String.IsNullOrEmpty(sort))
                    {
                        if (sort.Equals("title"))
                        {
                            published_notes = published_notes.OrderBy(m => m.Title).ToList();
                        }
                        if (sort.Equals("category"))
                        {
                            published_notes = published_notes.OrderBy(m => m.Category).ToList();
                        }
                        if (sort.Equals("notesize"))
                        {
                            published_notes = published_notes.OrderBy(m => m.NoteSize).ToList();
                        }
                        if (sort.Equals("price"))
                        {
                            published_notes = published_notes.OrderBy(m => m.SellPrice).ToList();
                        }
                        if (sort.Equals("seller"))
                        {
                            published_notes = published_notes.OrderBy(m => m.User.LastName).ToList();
                            published_notes = published_notes.OrderBy(m => m.User.FirstName).ToList();
                        }
                    }
                    if (!String.IsNullOrEmpty(search))
                    {
                        published_notes = published_notes.Where(m => m.Title.StartsWith(search) || m.Category.StartsWith(search) || m.SellPrice.ToString().StartsWith(search) || m.PublishedDate.ToString().StartsWith(search) || m.User.FirstName.StartsWith(search) || m.User.LastName.StartsWith(search)).ToList();
                    }

                    List<Dashboard_Admin> publishednotes = new List<Dashboard_Admin>();
                    foreach (NotesDetail note in published_notes)
                    {
                        Dashboard_Admin temp = new Dashboard_Admin();
                        temp.notesDetail = note;
                        temp.numberofdownload = db.DownloadedNotes.Where(m => m.IsApproved && m.F_K_Note == note.P_K_Note).Count();
                        publishednotes.Add(temp);
                    }
                    var dateCriteria = DateTime.Now.Date.AddDays(-7);
                    ViewBag.InReview_Notes = db.NotesDetails.Where(m => m.IsActive && m.F_K_NoteStatus == 2).Count();
                    ViewBag.DownloadedNotes = db.DownloadedNotes.Where(m => m.IsActive && m.IsApproved && m.CreatedDate >= dateCriteria).Count();
                    ViewBag.RegisterUSer = db.Users.Where(m => m.IsActive && m.F_K_UserRoles == 1 && m.CreaatedDate >= dateCriteria).Count();
                    return View(publishednotes.ToPagedList(pageindex ?? 1, 5));
                }
            }
            return HttpNotFound();
        }

        public ActionResult LogOut()
        {
            Register_id.id = 0;
            Register_id.profilepicture = null;
            Register_id.issuperadmin = false;
            return RedirectToAction("Home", "Home");
        }
        
        public ActionResult NoteUnderReview(int? pageindex, String sort, String search,String sellerid)
        {
            if (Register_id.id != 0)
            {
                List<NotesDetail> note_inreview = db.NotesDetails.Where(m => m.IsActive && (m.NotesStatu.P_K_NotesStatus == 2 || m.NotesStatu.P_K_NotesStatus == 3)).OrderByDescending(m => m.CreatedDate).ToList();
                if (!String.IsNullOrEmpty(sort))
                {
                    if (sort.Equals("title"))
                    {
                        note_inreview = note_inreview.OrderBy(m => m.Title).ToList();
                    }
                    if (sort.Equals("category"))
                    {
                        note_inreview = note_inreview.OrderBy(m => m.Category).ToList();
                    }
                    if (sort.Equals("status"))
                    {
                        note_inreview = note_inreview.OrderBy(m => m.NotesStatu.Name).ToList();
                    }
                    if (sort.Equals("seller"))
                    {
                        note_inreview = note_inreview.OrderBy(m => m.User.LastName).ToList();
                        note_inreview = note_inreview.OrderBy(m => m.User.FirstName).ToList();
                    }
                }
                if (!String.IsNullOrEmpty(search))
                {
                    note_inreview = note_inreview.Where(m => m.Title.StartsWith(search) || m.Category.StartsWith(search) || m.NotesStatu.Name.ToString().StartsWith(search) || m.CreatedDate.ToString().StartsWith(search) || m.User.FirstName.StartsWith(search) || m.User.LastName.StartsWith(search)).ToList();
                }

                var temp_seller = note_inreview.Select(m => m.F_K_User).Distinct().ToList();
                List<Id_Name> seller = new List<Id_Name>();
                foreach (int id in temp_seller)
                {
                    Id_Name temp = new Id_Name();
                    temp.id = id;
                    var user = db.Users.FirstOrDefault(m => m.P_K_User == id);
                    temp.name = user.FirstName + " " + user.LastName;
                    seller.Add(temp);
                }

                ViewBag.seller = seller;
                if (!String.IsNullOrEmpty(sellerid))
                {
                    note_inreview = note_inreview.Where(m => m.F_K_User.ToString().Equals(sellerid)).ToList();
                }

                return View(note_inreview.ToPagedList(pageindex ?? 1, 5));
            }
            return HttpNotFound();
        }

        public ActionResult PublishedNotes(int? pageindex, String sort, String search, String sellerid)
        {
            if (Register_id.id != 0)
            {
                List<NotesDetail> note_published = db.NotesDetails.Where(m => m.IsActive && m.NotesStatu.P_K_NotesStatus == 4).OrderByDescending(m => m.PublishedDate).ToList();
                if (!String.IsNullOrEmpty(sort))
                {
                    if (sort.Equals("title"))
                    {
                        note_published = note_published.OrderBy(m => m.Title).ToList();
                    }
                    if (sort.Equals("category"))
                    {
                        note_published = note_published.OrderBy(m => m.Category).ToList();
                    }
                    if (sort.Equals("price"))
                    {
                        note_published = note_published.OrderBy(m => m.SellPrice).ToList();
                    }
                    if (sort.Equals("seller"))
                    {
                        note_published = note_published.OrderBy(m => m.User.LastName).ToList();
                        note_published = note_published.OrderBy(m => m.User.FirstName).ToList();
                    }
                }
                if (!String.IsNullOrEmpty(search))
                {
                    note_published = note_published.Where(m => m.Title.StartsWith(search) || m.Category.StartsWith(search) || m.SellPrice.ToString().StartsWith(search) || m.PublishedDate.ToString().StartsWith(search) || m.User.FirstName.StartsWith(search) || m.User.LastName.StartsWith(search)).ToList();
                }

                var temp_seller = note_published.Select(m => m.F_K_User).Distinct().ToList();
                List<Id_Name> seller = new List<Id_Name>();
                foreach (int id in temp_seller)
                {
                    Id_Name temp = new Id_Name();
                    temp.id = id;
                    var user = db.Users.FirstOrDefault(m => m.P_K_User == id);
                    temp.name = user.FirstName + " " + user.LastName;
                    seller.Add(temp);
                }

                ViewBag.seller = seller;
                if (!String.IsNullOrEmpty(sellerid))
                {
                    note_published = note_published.Where(m => m.F_K_User.ToString().Equals(sellerid)).ToList();
                }

                List<Dashboard_Admin> publishednotes = new List<Dashboard_Admin>();
                foreach (NotesDetail note in note_published)
                {
                    Dashboard_Admin temp = new Dashboard_Admin();
                    temp.notesDetail = note;
                    temp.numberofdownload = db.DownloadedNotes.Where(m => m.IsApproved && m.F_K_Note == note.P_K_Note).Count();
                    var user = db.Users.FirstOrDefault(m => m.P_K_User == note.ModifiedBy);
                    temp.ApprovedBy = user.FirstName + " " + user.LastName;
                    publishednotes.Add(temp);
                }

                return View(publishednotes.ToPagedList(pageindex ?? 1, 5));
            }
            return HttpNotFound();
        }

        public ActionResult DownloadedNotes(String noteid,int? pageindex, String sort, String search,String sellerid,String buyerid)
        {
            if(Register_id.id!=0)
            {
                List<DownloadedNote> downloadedNotes = db.DownloadedNotes.Where(m => m.IsActive && m.IsApproved).OrderByDescending(m=>m.CreatedDate).ToList();

                if (!String.IsNullOrEmpty(sort))
                {
                    if (sort.Equals("title"))
                    {
                        downloadedNotes = downloadedNotes.OrderBy(m => m.Title).ToList();
                    }
                    if (sort.Equals("category"))
                    {
                        downloadedNotes = downloadedNotes.OrderBy(m => m.Category).ToList();
                    }
                    if (sort.Equals("buyer"))
                    {
                        downloadedNotes = downloadedNotes.OrderBy(m => m.User1.LastName).ToList();
                        downloadedNotes = downloadedNotes.OrderBy(m => m.User1.FirstName).ToList();
                    }
                    if (sort.Equals("price"))
                    {
                        downloadedNotes = downloadedNotes.OrderBy(m => m.SellPrice).ToList();
                    }
                    if (sort.Equals("seller"))
                    {
                        downloadedNotes = downloadedNotes.OrderBy(m => m.User.LastName).ToList();
                        downloadedNotes = downloadedNotes.OrderBy(m => m.User.FirstName).ToList();
                    }
                }
                if (!String.IsNullOrEmpty(search))
                {
                    downloadedNotes = downloadedNotes.Where(m => m.Title.StartsWith(search) || m.Category.StartsWith(search) || m.SellPrice.ToString().StartsWith(search) || m.CreatedDate.ToString().StartsWith(search) || m.User.FirstName.StartsWith(search) || m.User.LastName.StartsWith(search) || m.User1.FirstName.StartsWith(search) || m.User1.LastName.StartsWith(search)).ToList();
                }

                var temp_seller = downloadedNotes.Select(m => m.F_K_User_Seller).Distinct().ToList();
                var temp_buyer = downloadedNotes.Select(m => m.F_K_User_Buyer).Distinct().ToList();
                var temp_note = downloadedNotes.Select(m => m.F_K_Note).Distinct().ToList();

                List<Id_Name> seller = new List<Id_Name>();
                foreach(int id in temp_seller)
                {
                    Id_Name temp = new Id_Name();
                    temp.id = id;
                    var user = db.Users.FirstOrDefault(m=>m.P_K_User==id);
                    temp.name = user.FirstName + " " + user.LastName;
                    seller.Add(temp);
                }
                
                List<Id_Name> buyer = new List<Id_Name>();
                foreach (int id in temp_buyer)
                {
                    Id_Name temp = new Id_Name();
                    temp.id = id;
                    var user = db.Users.FirstOrDefault(m => m.P_K_User == id);
                    temp.name = user.FirstName + " " + user.LastName;
                    buyer.Add(temp);
                }
              
                List<Id_Name> note = new List<Id_Name>();
                foreach (int id in temp_note)
                {
                    Id_Name temp = new Id_Name();
                    temp.id = id;
                    var notedetails = db.NotesDetails.FirstOrDefault(m => m.P_K_Note == id);
                    temp.name = notedetails.Title;
                    note.Add(temp);
                }

                ViewBag.seller = seller;
                ViewBag.buyer = buyer;
                ViewBag.note = note;

                if(!String.IsNullOrEmpty(noteid))
                {
                    downloadedNotes = downloadedNotes.Where(m => m.F_K_Note.ToString().Equals(noteid)).ToList();
                }
                if (!String.IsNullOrEmpty(sellerid))
                {
                    downloadedNotes = downloadedNotes.Where(m => m.F_K_User_Seller.ToString().Equals(sellerid)).ToList();
                }
                if (!String.IsNullOrEmpty(buyerid))
                {
                    downloadedNotes = downloadedNotes.Where(m => m.F_K_User_Buyer.ToString().Equals(buyerid)).ToList();
                }

                return View(downloadedNotes.ToPagedList(pageindex ?? 1, 5));
            }
            return HttpNotFound();
        }

        public ActionResult RejectedNotes(int? pageindex, String sort, String search, String sellerid)
        {
            if (Register_id.id != 0)
            {
                List<NotesDetail> note_rejected = db.NotesDetails.Where(m => m.IsActive && m.NotesStatu.P_K_NotesStatus == 5).OrderByDescending(m => m.CreatedDate).ToList();
                if (!String.IsNullOrEmpty(sort))
                {
                    if (sort.Equals("title"))
                    {
                        note_rejected = note_rejected.OrderBy(m => m.Title).ToList();
                    }
                    if (sort.Equals("category"))
                    {
                        note_rejected = note_rejected.OrderBy(m => m.Category).ToList();
                    }
                    if (sort.Equals("seller"))
                    {
                        note_rejected = note_rejected.OrderBy(m => m.User.LastName).ToList();
                        note_rejected = note_rejected.OrderBy(m => m.User.FirstName).ToList();
                    }
                }
                if (!String.IsNullOrEmpty(search))
                {
                    note_rejected = note_rejected.Where(m => m.Title.StartsWith(search) || m.Category.StartsWith(search) || m.CreatedDate.ToString().StartsWith(search) || m.User.FirstName.StartsWith(search) || m.User.LastName.StartsWith(search)).ToList();
                }

                var temp_seller = note_rejected.Select(m => m.F_K_User).Distinct().ToList();
                List<Id_Name> seller = new List<Id_Name>();
                foreach (int id in temp_seller)
                {
                    Id_Name temp = new Id_Name();
                    temp.id = id;
                    var user = db.Users.FirstOrDefault(m => m.P_K_User == id);
                    temp.name = user.FirstName + " " + user.LastName;
                    seller.Add(temp);
                }

                ViewBag.seller = seller;
                if (!String.IsNullOrEmpty(sellerid))
                {
                    note_rejected = note_rejected.Where(m => m.F_K_User.ToString().Equals(sellerid)).ToList();
                }

                List<Dashboard_Admin> rejectednotes = new List<Dashboard_Admin>();
                foreach (NotesDetail note in note_rejected)
                {
                    Dashboard_Admin temp = new Dashboard_Admin();
                    temp.notesDetail = note;
                    var user = db.Users.FirstOrDefault(m => m.P_K_User == note.ModifiedBy);
                    temp.ApprovedBy = user.FirstName + " " + user.LastName;
                    rejectednotes.Add(temp);
                }

                return View(rejectednotes.ToPagedList(pageindex ?? 1, 5));
            }
            return HttpNotFound();
        }
        public ActionResult Members(int? pageindex, String sort, String search)
        {
            if (Register_id.id != 0)
            {
                List<User> users = db.Users.Where(m => m.IsActive && m.F_K_UserRoles==1).OrderByDescending(m => m.CreaatedDate).ToList();

                if (!String.IsNullOrEmpty(sort))
                {
                    if (sort.Equals("fname"))
                    {
                        users = users.OrderBy(m => m.FirstName).ToList();
                    }
                    if (sort.Equals("lname"))
                    {
                        users = users.OrderBy(m => m.LastName).ToList();
                    }
                    if (sort.Equals("email"))
                    {
                        users = users.OrderBy(m => m.EmailId).ToList();
                    }
                }
                if (!String.IsNullOrEmpty(search))
                {
                    users = users.Where(m => m.FirstName.StartsWith(search) || m.LastName.StartsWith(search) || m.CreaatedDate.ToString().StartsWith(search) || m.EmailId.StartsWith(search)).ToList();
                }

                List<Member> members = new List<Member>();
                List<DownloadedNote> downloadedNotes = db.DownloadedNotes.ToList();
                foreach (User member in users)
                {
                    Member temp = new Member();
                    temp.user = member;
                    
                    temp.downloadednotes = downloadedNotes.Where(m => m.F_K_User_Buyer == member.P_K_User && m.IsActive && m.IsApproved == true).ToList().Count();
                    temp.publshednotes = db.NotesDetails.Where(m => m.IsActive && (m.F_K_NoteStatus == 4) && m.F_K_User == member.P_K_User).ToList().Count();
                    temp.underreviewnotes= db.NotesDetails.Where(m => m.IsActive && (m.F_K_NoteStatus == 2) && m.F_K_User == member.P_K_User).ToList().Count();
                    var temp2 = downloadedNotes.Where(m => m.F_K_User_Seller == member.P_K_User && m.IsActive && m.IsApproved == true).ToList().Count();
                    if (temp2 != 0)
                    {
                        temp.totalearning = downloadedNotes.Where(m => m.F_K_User_Seller == member.P_K_User && m.IsActive && m.IsApproved == true).ToList().Sum(m => m.SellPrice);
                    }
                    var temp3 = downloadedNotes.Where(m => m.F_K_User_Buyer == member.P_K_User && m.IsActive && m.IsApproved == true).ToList().Count();
                    if (temp3 != 0)
                    {
                        temp.totalexpensis= downloadedNotes.Where(m => m.F_K_User_Buyer == member.P_K_User && m.IsActive && m.IsApproved == true).ToList().Sum(m => m.SellPrice);
                    }
                    members.Add(temp);
                }
                return View(members.ToPagedList(pageindex ?? 1, 5));
            }
            return HttpNotFound();
        }
        public ActionResult MemberDatails(String id, int? pageindex, String sort)
        {
            if(Register_id.id!=0)
            {
                if (!String.IsNullOrEmpty(id))
                {
                    User user = db.Users.FirstOrDefault(m=>m.P_K_User.ToString().Equals(id));
                    if(user!=null)
                    {
                        UserProfile userProfile = db.UserProfiles.FirstOrDefault(m => m.F_K_User == user.P_K_User);
                        if(userProfile!=null)
                        {
                            List<NotesDetail> mynotes = db.NotesDetails.Where(m => m.IsActive && m.F_K_NoteStatus != 1 &&m.F_K_User==user.P_K_User).OrderByDescending(m=>m.CreatedDate).ToList();
                            if (!String.IsNullOrEmpty(sort))
                            {
                                if (sort.Equals("title"))
                                {
                                    mynotes = mynotes.OrderBy(m => m.Title).ToList();
                                }
                                if (sort.Equals("category"))
                                {
                                    mynotes = mynotes.OrderBy(m => m.Category).ToList();
                                }
                                if (sort.Equals("status"))
                                {
                                    mynotes = mynotes.OrderBy(m => m.NotesStatu.Name).ToList();
                                }
                                if (sort.Equals("pdate"))
                                {
                                    mynotes = mynotes.OrderBy(m => m.PublishedDate).ToList();
                                }
                            }
                            ViewBag.notes = mynotes.ToPagedList(pageindex ?? 1, 5);
                            return View(userProfile);
                        }
                    }
                }
            }
            return HttpNotFound();
        }

        public ActionResult SpamReports(int? pageindex, String sort, String search)
        {
            if (Register_id.id != 0)
            {
                List<SpamReport> reports = db.SpamReports.OrderByDescending(m=>m.CreatedDate).ToList();
                if (!String.IsNullOrEmpty(sort))
                {
                    if (sort.Equals("title"))
                    {
                        reports = reports.OrderBy(m => m.NotesDetail.Title).ToList();
                    }
                    if (sort.Equals("category"))
                    {
                        reports = reports.OrderBy(m => m.NotesDetail.Category).ToList();
                    }
                }
                if (!String.IsNullOrEmpty(search))
                {
                    reports = reports.Where(m => m.NotesDetail.Title.StartsWith(search) || m.NotesDetail.Category.StartsWith(search) || m.CreatedDate.ToString().StartsWith(search)).ToList();
                }
                return View(reports.ToPagedList(pageindex ?? 1, 5));
            }
            return HttpNotFound();
        }

        public ActionResult DeletepamReport(String id)
        {
            if(Register_id.id!=0)
            {
                if(!String.IsNullOrEmpty(id))
                {
                    SpamReport report = db.SpamReports.FirstOrDefault(m => m.ID.ToString().Equals(id));
                    if(report!=null)
                    {
                        db.SpamReports.Remove(report);
                        db.SaveChanges();
                        return RedirectToAction("SpamReports", "Admin");
                    }
                }
            }
            return HttpNotFound();
        }

        public ActionResult ManageSystemConfiguration()
        {
            if (Register_id.id != 0)
            {
                SystemConfiguration temp = db.SystemConfigurations.FirstOrDefault();
                return View(temp);
            }
            return HttpNotFound();
        }
        [HttpPost]
        public ActionResult ManageSystemConfiguration(SystemConfiguration config)
        {
            if (Register_id.id != 0)
            {
                if(config!=null)
                {
                    if (config.DNP != null)
                    {
                        string path = Server.MapPath("~/Uploads/BookPicture/Default");
                        String extension = Path.GetExtension(config.DNP.FileName);
                        var supportedTypes = new[] { ".jpg", ".jpeg", ".png" };
                        if (supportedTypes.Contains(extension.ToUpper()) || supportedTypes.Contains(extension.ToLower()))
                        {
                            config.DNP.SaveAs(Path.Combine(path+extension));
                            config.DefaultNotePreview = "Default"+extension;
                            List<NotesDetail> notesDetails = db.NotesDetails.Where(m => String.IsNullOrEmpty(m.BookPicture)|| m.BookPicture.StartsWith("Default")).ToList();
                            foreach(NotesDetail notesDetail in notesDetails)
                            {
                                NotesDetail temp_note = db.NotesDetails.FirstOrDefault(m=>m.P_K_Note==notesDetail.P_K_Note);
                                temp_note.BookPicture = config.DefaultNotePreview;
                                db.SaveChanges();
                               
                            }
                        }
                        else
                        {
                            ViewBag.DNP = "Choose images  only";
                            return View(config);
                        }
                    }
                    if (config.DPP != null)
                    {
                        string path = Server.MapPath("~/Uploads/ProfilePicture/Default");
                        String extension = Path.GetExtension(config.DPP.FileName);
                        var supportedTypes = new[] { ".jpg", ".jpeg", ".png" };
                        if (supportedTypes.Contains(extension.ToUpper()) || supportedTypes.Contains(extension.ToLower()))
                        {
                            config.DPP.SaveAs(Path.Combine(path+extension));
                            config.DefaultProfilePicture = "Default"+extension;
                            List<UserProfile> userProfiles = db.UserProfiles.Where(m => String.IsNullOrEmpty(m.ProfilePicture) || m.ProfilePicture.StartsWith("Default")).ToList();
                            foreach (UserProfile userProfile in userProfiles)
                            {
                                UserProfile temp_profile = db.UserProfiles.FirstOrDefault(m => m.ID == userProfile.ID);
                                temp_profile.ProfilePicture = config.DefaultProfilePicture;
                                temp_profile.Number = "1234";
                                temp_profile.CountryCode = "91";
                                db.SaveChanges();
                            }
                            List<AdminProfile> adminProfiles = db.AdminProfiles.Where(m => String.IsNullOrEmpty(m.ProfilePicture) || m.ProfilePicture.StartsWith("Default")).ToList();
                            foreach (AdminProfile adminProfile in adminProfiles)
                            {
                                AdminProfile temp_profile = db.AdminProfiles.FirstOrDefault(m => m.ID == adminProfile.ID);
                                temp_profile.ProfilePicture = config.DefaultProfilePicture;
                                db.SaveChanges();
                            }

                        }
                        else
                        {
                            ViewBag.DPP = "Choose images  only";
                            return View(config);
                        }
                    }

                    config.CreatedDate = DateTime.Now;
                    SystemConfiguration temp = db.SystemConfigurations.FirstOrDefault();
                    if(temp!=null)
                    {
                        temp.EmaillId1 = config.EmaillId1;
                        temp.EmailId2 = config.EmailId2;
                        temp.FacebookUrl = config.FacebookUrl;
                        temp.PhoneNumber = config.PhoneNumber;
                        temp.LinkInUrl = config.LinkInUrl;
                        temp.TwitterUrl = config.TwitterUrl;
                        temp.ModifiedDate = DateTime.Now;
                    }
                    else
                    {
                        config.ID = 0;
                        db.SystemConfigurations.Add(config);
                    }
                    db.SaveChanges();

                    return RedirectToAction("Dashboard", "Admin");
                }
            }
            return HttpNotFound();
        }

        public ActionResult ManageAdministrator(int? pageindex, String sort, String search)
        {
            if (Register_id.id != 0)
            {
                List<User> Admin_user = db.Users.Where(m =>m.F_K_UserRoles == 2 || m.F_K_UserRoles == 3).OrderByDescending(m => m.CreaatedDate).ToList();
                if (!String.IsNullOrEmpty(sort))
                {
                    if (sort.Equals("fname"))
                    {
                        Admin_user = Admin_user.OrderBy(m => m.FirstName).ToList();
                    }
                    if (sort.Equals("lname"))
                    {
                        Admin_user = Admin_user.OrderBy(m => m.LastName).ToList();
                    }
                    if (sort.Equals("email"))
                    {
                        Admin_user = Admin_user.OrderBy(m => m.EmailId).ToList();
                    }
                }
                if (!String.IsNullOrEmpty(search))
                {
                    Admin_user = Admin_user.Where(m => m.FirstName.StartsWith(search) || m.LastName.StartsWith(search) || m.EmailId.ToString().StartsWith(search) || m.CreaatedDate.ToString().StartsWith(search)).ToList();
                }

                return View(Admin_user.ToPagedList(pageindex ?? 1, 5));
            }
            return HttpNotFound();
        }

        public ActionResult AddAdministrator()
        {
            if(Register_id.id!=0)
            {
                ViewBag.MyCTC = db.ManageCTCs.Where(m => m.IsActive == true &&m.F_K_CTC==3).ToList();
                return View(new AdminProfile());
            }
            return HttpNotFound();
        }

        [HttpPost]
        public ActionResult AddAdministrator(AdminProfile adminProfile)
        {
            if (Register_id.id != 0)
            {
                if (adminProfile != null)
                {
                    var isEmailAlreadyExists = db.Users.Any(x => x.EmailId == adminProfile.User.EmailId);
                    if (isEmailAlreadyExists)
                    {
                        ViewBag.flag = "Exits";
                        ViewBag.MyCTC = db.ManageCTCs.Where(m => m.IsActive == true && m.F_K_CTC == 3).ToList();
                        return View(adminProfile);
                    }
                    else
                    {
                        User user = adminProfile.User;
                        user.IsActive = true;
                        user.F_K_UserRoles = 2;
                        user.Password = "123456";
                        user.Password2 = user.Password;
                        user.CreaatedDate = DateTime.Now;
                        db.Users.Add(user);
                        db.SaveChanges();

                        if (adminProfile.CountryCode != null && adminProfile.Number != null)
                        {
                            adminProfile.PhoneNumber = adminProfile.CountryCode + adminProfile.Number;
                        }
                        adminProfile.IsActive = true;
                        adminProfile.SecondaryEmail = adminProfile.User.EmailId;
                        adminProfile.ProfilePicture = db.SystemConfigurations.FirstOrDefault().DefaultProfilePicture;
                        adminProfile.F_K_User = db.Users.FirstOrDefault(m => m.EmailId == adminProfile.User.EmailId).P_K_User;
                        db.AdminProfiles.Add(adminProfile);
                        db.SaveChanges();
                    }
                    return RedirectToAction("ManageAdministrator", "Admin");
                }
            }
            return HttpNotFound();
        }

        public ActionResult EditAdministrator(String id)
        {
            if (Register_id.id != 0)
            {
                if(!String.IsNullOrEmpty(id))
                {
                    AdminProfile temp = db.AdminProfiles.FirstOrDefault(m => m.F_K_User.ToString().Equals(id));
                    if(temp!=null)
                    {
                        if (temp.PhoneNumber != null)
                        {
                            temp.CountryCode = temp.PhoneNumber.Substring(0, 3);
                            temp.Number = temp.PhoneNumber.Substring(3);
                        }
                        ViewBag.MyCTC = db.ManageCTCs.Where(m => m.IsActive == true && m.F_K_CTC == 3).ToList();
                        return View("AddAdministrator", temp);
                    }
                }
            }
            return HttpNotFound();
        }

        [HttpPost]
        public ActionResult EditAdministrator(AdminProfile adminProfile)
        {
            if (Register_id.id != 0)
            {
                if (adminProfile != null)
                {
                    AdminProfile edit = db.AdminProfiles.FirstOrDefault(m => m.ID == adminProfile.ID);
                    if(edit!=null)
                    {
                        var isEmailAlreadyExists = db.Users.Any(x => x.EmailId == adminProfile.User.EmailId && x.P_K_User!=edit.F_K_User);
                        if (isEmailAlreadyExists)
                        {
                            ViewBag.flag = "Exits";
                            ViewBag.MyCTC = db.ManageCTCs.Where(m => m.IsActive == true && m.F_K_CTC == 3).ToList();
                            return View("AddAdministrator",adminProfile);
                        }
                        else
                        {
                            User user = db.Users.FirstOrDefault(m=>m.P_K_User==edit.F_K_User);
                            user.FirstName = adminProfile.User.FirstName;
                            user.LastName = adminProfile.User.LastName;
                            user.EmailId = adminProfile.User.EmailId;
                            user.Password2 = user.Password;
                            user.ModifiedDate = DateTime.Now;
                            user.IsActive = true;

                            if (adminProfile.CountryCode != null && adminProfile.Number != null)
                            {
                                edit.PhoneNumber = adminProfile.CountryCode + adminProfile.Number;
                            }
                            db.SaveChanges();
                        }
                    }
                    return RedirectToAction("ManageAdministrator", "Admin");
                }
            }
            return HttpNotFound();
        }


        public ActionResult ManageCategory(int? pageindex, String sort, String search)
        {
            if (Register_id.id != 0)
            {
                List<ManageCTC> categories = db.ManageCTCs.Where(m=>m.F_K_CTC == 1).OrderByDescending(m => m.CreatedDate).ToList();
                if (!String.IsNullOrEmpty(sort))
                {
                    if (sort.Equals("category"))
                    {
                        categories = categories.OrderBy(m => m.Value).ToList();
                    }
                }
                if (!String.IsNullOrEmpty(search))
                {
                    categories = categories.Where(m => m.Value.StartsWith(search) || m.CreatedDate.ToString().StartsWith(search)).ToList();
                }

                List<ManageCTC_Admin> manageCTC_Admins = new List<ManageCTC_Admin>();
                foreach (ManageCTC category in categories)
                {
                    ManageCTC_Admin temp = new ManageCTC_Admin();
                    temp.manageCTC = category;
                    var user = db.Users.FirstOrDefault(m => m.P_K_User == category.CreatedBy);
                    temp.name = user.FirstName + " " + user.LastName;
                    manageCTC_Admins.Add(temp);
                }

                return View(manageCTC_Admins.ToPagedList(pageindex ?? 1, 5));
            }
            return HttpNotFound();
        }
        public ActionResult AddCategory()
        {
            if (Register_id.id != 0)
            {
                return View(new ManageCTC());
            }
            return HttpNotFound();
        }
        [HttpPost]
        public ActionResult AddCategory(ManageCTC manageCTC)
        {
            if (Register_id.id != 0)
            {
                if (manageCTC != null)
                {
                    ManageCTC temp = db.ManageCTCs.FirstOrDefault(m=>m.Value.ToString().ToLower().Equals(manageCTC.Value.ToLower()));
                    if (temp==null)
                    {
                        manageCTC.F_K_CTC = 1;
                        manageCTC.CreatedBy = Register_id.id;
                        manageCTC.CreatedDate = DateTime.Now;
                        manageCTC.IsActive = true;
                        db.ManageCTCs.Add(manageCTC);
                    }
                    else
                    {
                        temp.ModifiedBy = Register_id.id;
                        temp.ModifiedDate = DateTime.Now;
                    }
                    db.SaveChanges();
                    return RedirectToAction("ManageCategory","Admin");
                }
            }
            return HttpNotFound();
        }
        public ActionResult EditCategory(String id)
        {
            if(!String.IsNullOrEmpty(id))
            {
                ManageCTC manageCTC = db.ManageCTCs.FirstOrDefault(m =>m.ID.ToString().Equals(id));
                if(manageCTC!=null)
                {
                    return View("AddCategory", manageCTC);
                }
            }
            return HttpNotFound();
        }
        [HttpPost]
        public ActionResult EditCategory(ManageCTC manageCTC)
        {
            if (Register_id.id != 0)
            {
                if (manageCTC != null)
                {
                    ManageCTC temp = db.ManageCTCs.FirstOrDefault(m =>m.ID==manageCTC.ID);
                    if (temp != null)
                    {
                        temp.Value = manageCTC.Value;
                        temp.Description = manageCTC.Description;
                        temp.ModifiedBy = Register_id.id;
                        temp.IsActive = true;
                        temp.ModifiedDate = DateTime.Now;
                    }
                    db.SaveChanges();
                    return RedirectToAction("ManageCategory", "Admin");
                }
            }
            return HttpNotFound();
        }
        public ActionResult DeleteCategory(String id)
        {
            if (Register_id.id != 0)
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ManageCTC temp = db.ManageCTCs.FirstOrDefault(m => m.ID.ToString().Equals(id));
                    if (temp != null)
                    {
                        temp.IsActive = false;
                    }
                    db.SaveChanges();
                    return RedirectToAction("ManageCategory", "Admin");
                }
            }
            return HttpNotFound();
        }

        public ActionResult ManageType(int? pageindex, String sort, String search)
        {
            if (Register_id.id != 0)
            {
                List<ManageCTC> categories = db.ManageCTCs.Where(m => m.F_K_CTC == 2).OrderByDescending(m => m.CreatedDate).ToList();
                if (!String.IsNullOrEmpty(sort))
                {
                    if (sort.Equals("category"))
                    {
                        categories = categories.OrderBy(m => m.Value).ToList();
                    }
                }
                if (!String.IsNullOrEmpty(search))
                {
                    categories = categories.Where(m => m.Value.StartsWith(search) || m.CreatedDate.ToString().StartsWith(search)).ToList();
                }

                List<ManageCTC_Admin> manageCTC_Admins = new List<ManageCTC_Admin>();
                foreach (ManageCTC category in categories)
                {
                    ManageCTC_Admin temp = new ManageCTC_Admin();
                    temp.manageCTC = category;
                    var user = db.Users.FirstOrDefault(m => m.P_K_User == category.CreatedBy);
                    temp.name = user.FirstName + " " + user.LastName;
                    manageCTC_Admins.Add(temp);
                }

                return View(manageCTC_Admins.ToPagedList(pageindex ?? 1, 5));
            }
            return HttpNotFound();
        }
        public ActionResult AddType()
        {
            if (Register_id.id != 0)
            {
                return View(new ManageCTC());
            }
            return HttpNotFound();
        }
        [HttpPost]
        public ActionResult AddType(ManageCTC manageCTC)
        {
            if (Register_id.id != 0)
            {
                if (manageCTC != null)
                {
                    ManageCTC temp = db.ManageCTCs.FirstOrDefault(m => m.Value.ToString().ToLower().Equals(manageCTC.Value.ToLower()));
                    if (temp == null)
                    {
                        manageCTC.F_K_CTC = 2;
                        manageCTC.CreatedBy = Register_id.id;
                        manageCTC.CreatedDate = DateTime.Now;
                        manageCTC.IsActive = true;
                        db.ManageCTCs.Add(manageCTC);
                    }
                    else
                    {
                        temp.ModifiedBy = Register_id.id;
                        temp.ModifiedDate = DateTime.Now;
                    }
                    db.SaveChanges();
                    return RedirectToAction("ManageType", "Admin");
                }
            }
            return HttpNotFound();
        }
        public ActionResult EditType(String id)
        {
            if (!String.IsNullOrEmpty(id))
            {
                ManageCTC manageCTC = db.ManageCTCs.FirstOrDefault(m => m.ID.ToString().Equals(id));
                if (manageCTC != null)
                {
                    return View("AddType", manageCTC);
                }
            }
            return HttpNotFound();
        }
        [HttpPost]
        public ActionResult EditType(ManageCTC manageCTC)
        {
            if (Register_id.id != 0)
            {
                if (manageCTC != null)
                {
                    ManageCTC temp = db.ManageCTCs.FirstOrDefault(m => m.ID == manageCTC.ID);
                    if (temp != null)
                    {
                        temp.Value = manageCTC.Value;
                        temp.Description = manageCTC.Description;
                        temp.ModifiedBy = Register_id.id;
                        temp.IsActive = true;
                        temp.ModifiedDate = DateTime.Now;
                    }
                    db.SaveChanges();
                    return RedirectToAction("ManageType", "Admin");
                }
            }
            return HttpNotFound();
        }
        public ActionResult DeleteType(String id)
        {
            if (Register_id.id != 0)
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ManageCTC temp = db.ManageCTCs.FirstOrDefault(m => m.ID.ToString().Equals(id));
                    if (temp != null)
                    {
                        temp.IsActive = false;
                    }
                    db.SaveChanges();
                    return RedirectToAction("ManageType", "Admin");
                }
            }
            return HttpNotFound();
        }


        public ActionResult ManageCountry(int? pageindex, String sort, String search)
        {
            if (Register_id.id != 0)
            {
                List<ManageCTC> categories = db.ManageCTCs.Where(m => m.F_K_CTC == 3).OrderByDescending(m => m.CreatedDate).ToList();
                if (!String.IsNullOrEmpty(sort))
                {
                    if (sort.Equals("category"))
                    {
                        categories = categories.OrderBy(m => m.Value).ToList();
                    }
                }
                if (!String.IsNullOrEmpty(search))
                {
                    categories = categories.Where(m => m.Value.StartsWith(search) || m.CreatedDate.ToString().StartsWith(search)).ToList();
                }

                List<ManageCTC_Admin> manageCTC_Admins = new List<ManageCTC_Admin>();
                foreach (ManageCTC category in categories)
                {
                    ManageCTC_Admin temp = new ManageCTC_Admin();
                    temp.manageCTC = category;
                    var user = db.Users.FirstOrDefault(m => m.P_K_User == category.CreatedBy);
                    temp.name = user.FirstName + " " + user.LastName;
                    manageCTC_Admins.Add(temp);
                }

                return View(manageCTC_Admins.ToPagedList(pageindex ?? 1, 5));
            }
            return HttpNotFound();
        }
        public ActionResult AddCountry()
        {
            return View(new ManageCTC());
        }
        [HttpPost]
        public ActionResult AddCountry(ManageCTC manageCTC)
        {
            if (Register_id.id != 0)
            {
                if (manageCTC != null)
                {
                    ManageCTC temp = db.ManageCTCs.FirstOrDefault(m => m.Value.ToString().ToLower().Equals(manageCTC.Value.ToLower()));
                    if (temp == null)
                    {
                        manageCTC.F_K_CTC = 3;
                        manageCTC.CreatedBy = Register_id.id;
                        manageCTC.CreatedDate = DateTime.Now;
                        manageCTC.IsActive = true;
                        db.ManageCTCs.Add(manageCTC);
                    }
                    else
                    {
                        temp.ModifiedBy = Register_id.id;
                        temp.ModifiedDate = DateTime.Now;
                    }
                    db.SaveChanges();
                    return RedirectToAction("ManageCountry", "Admin");
                }
            }
            return HttpNotFound();
        }
        public ActionResult EditCountry(String id)
        {
            if (!String.IsNullOrEmpty(id))
            {
                ManageCTC manageCTC = db.ManageCTCs.FirstOrDefault(m => m.ID.ToString().Equals(id));
                if (manageCTC != null)
                {
                    return View("AddCountry", manageCTC);
                }
            }
            return HttpNotFound();
        }
        [HttpPost]
        public ActionResult EditCountry(ManageCTC manageCTC)
        {
            if (Register_id.id != 0)
            {
                if (manageCTC != null)
                {
                    ManageCTC temp = db.ManageCTCs.FirstOrDefault(m => m.ID == manageCTC.ID);
                    if (temp != null)
                    {
                        temp.Value = manageCTC.Value;
                        temp.CountryCode = manageCTC.CountryCode;
                        temp.ModifiedBy = Register_id.id;
                        temp.IsActive = true;
                        temp.ModifiedDate = DateTime.Now;
                    }
                    db.SaveChanges();
                    return RedirectToAction("ManageCountry", "Admin");
                }
            }
            return HttpNotFound();
        }
        public ActionResult DeleteCountry(String id)
        {
            if (Register_id.id != 0)
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ManageCTC temp = db.ManageCTCs.FirstOrDefault(m => m.ID.ToString().Equals(id));
                    if (temp != null)
                    {
                        temp.IsActive = false;
                    }
                    db.SaveChanges();
                    return RedirectToAction("ManageCountry", "Admin");
                }
            }
            return HttpNotFound();
        }

        public ActionResult MyProfile()
        {
            if (Register_id.id != 0)
            {
                AdminProfile adminProfile = db.AdminProfiles.FirstOrDefault(m => m.F_K_User == Register_id.id);
                if(adminProfile!=null)
                {
                    ViewBag.MyCTC = db.ManageCTCs.Where(m => m.IsActive == true && m.F_K_CTC == 3).ToList();
                    ViewBag.PP = adminProfile.ProfilePicture;
                    if (adminProfile.PhoneNumber != null)
                    {
                        adminProfile.CountryCode = adminProfile.PhoneNumber.Substring(0, 3);
                        adminProfile.Number = adminProfile.PhoneNumber.Substring(3);
                    }
                    return View(adminProfile);
                }
            }
            return HttpNotFound();  
        }

        [HttpPost]
        public ActionResult MyProfile(AdminProfile adminProfile)
        {
            if (Register_id.id != 0)
            {
                AdminProfile temp = db.AdminProfiles.FirstOrDefault(m => m.User.EmailId == adminProfile.User.EmailId);
                if (adminProfile != null)
                {
                    string path = Server.MapPath("~/Uploads/ProfilePicture/");
                    if (adminProfile.PP != null)
                    {
                        String extension = Path.GetExtension(adminProfile.PP.FileName);
                        var supportedTypes = new[] { ".jpg", ".jpeg", ".png" };
                        if (supportedTypes.Contains(extension.ToUpper()) || supportedTypes.Contains(extension.ToLower()))
                        {
                            if (adminProfile.PP.ContentLength > 1024 * 1024 * 10)
                            {
                                ViewBag.MyCTC = db.ManageCTCs.Where(m => m.IsActive == true && m.F_K_CTC == 3).ToList();
                                ViewBag.PP = "File size should be less then 10 MB";
                                return View(adminProfile);
                            }
                            string fileName = Register_id.id.ToString() + "hfhbshvbadyig" + extension;
                            adminProfile.PP.SaveAs(Path.Combine(path, fileName));
                            temp.ProfilePicture = fileName;
                            Register_id.profilepicture = fileName;
                        }
                        else
                        {
                            ViewBag.MyCTC = db.ManageCTCs.Where(m => m.IsActive == true && m.F_K_CTC == 3).ToList();
                            ViewBag.PP = "Choose image only";
                            return View(adminProfile);
                        }
                    }
                    
                    if(adminProfile.CountryCode!=null && adminProfile.Number!=null)
                    {
                        temp.PhoneNumber = adminProfile.CountryCode + adminProfile.Number;
                    }
                    else
                    {
                        temp.PhoneNumber = null;
                    }
                    temp.SecondaryEmail = adminProfile.SecondaryEmail;
                    temp.ModifiedDate = DateTime.Now;
                    temp.IsActive = true;
                    User user = db.Users.FirstOrDefault(m => m.EmailId == adminProfile.User.EmailId);
                    if(user!=null)
                    {
                        user.FirstName = adminProfile.User.FirstName;
                        user.LastName = adminProfile.User.LastName;
                        user.Password2 = user.Password;
                        db.SaveChanges();
                    }
                    return RedirectToAction("Dashboard", "Admin");
                }
            }
            return HttpNotFound();
        }

        public ActionResult NoteDetails(String noteid)
        {
            if (Register_id.id != 0)
            {
                if (!String.IsNullOrEmpty(noteid))
                {
                    NotesDetail noteDetails = db.NotesDetails.FirstOrDefault(m => m.P_K_Note.ToString().Equals(noteid));
                    if (noteDetails != null)
                    {
                        ViewBag.rates = 0;
                        var temp = db.Feedbacks.Where(m => m.F_K_Note.ToString().Equals(noteid.ToString()) && m.IsActive);
                        if (temp != null)
                        {
                            var listofreviews = temp.ToList();
                            var count = listofreviews.Count();
                            if (count != 0)
                            {
                                int sum = 0;
                                for (int i = 0; i < count; i++)
                                {
                                    sum = sum + listofreviews[i].Review;
                                }
                                ViewBag.rates = sum / count;
                                List<Feedback> temp2 = listofreviews.OrderByDescending(m => m.CreatedDate).OrderByDescending(m => m.Review).ToList();
                                List<Feedbacks> feedbacks = new List<Feedbacks>();
                                foreach (Feedback feedback in temp2)
                                {
                                    Feedbacks tempfeedback = new Feedbacks();
                                    tempfeedback.feedbacks = feedback;
                                    tempfeedback.profileurl = db.UserProfiles.FirstOrDefault(m => m.F_K_User == feedback.User.P_K_User).ProfilePicture;
                                    feedbacks.Add(tempfeedback);
                                }
                                ViewBag.feedbacks = feedbacks;
                            }
                        }
                        ViewBag.numofreview = db.Feedbacks.Where(m => m.F_K_Note.ToString().Equals(noteid) && m.IsActive).Count();
                        ViewBag.inappropriate = db.SpamReports.Where(m => m.F_K_Note.ToString().Equals(noteid)).Count();
                        return View(noteDetails);
                    }
                }
            }     
            return HttpNotFound();
        }

        public ActionResult DeleteFeedback(String noteid,String feedbackid)
        {
            if(noteid!=null && feedbackid!=null)
            {
                Feedback deletefeedback = db.Feedbacks.FirstOrDefault(m=>m.ID.ToString().Equals(feedbackid));
                if(deletefeedback!=null)
                {
                    deletefeedback.IsActive = false;
                    db.SaveChanges();
                    return RedirectToAction("NoteDetails", new { noteid = noteid });
                }
            }
            return HttpNotFound();
        }
        public ActionResult UnPublishNote(String noteid,String Remarks,String view)
        {
            if (Register_id.id != 0)
            {
                if (noteid != null)
                {
                    NotesDetail noteDetail = db.NotesDetails.FirstOrDefault(m => m.P_K_Note.ToString().Equals(noteid));
                    if (noteDetail != null)
                    {
                        noteDetail.F_K_NoteStatus = 6;
                        noteDetail.Remark = Remarks;
                        noteDetail.ModifiedBy = Register_id.id;
                        db.SaveChanges();

                        try
                        {
                            MailMessage mail = new MailMessage(db.SystemConfigurations.FirstOrDefault().EmaillId1, noteDetail.User.EmailId);
                            mail.Subject = "Sorry! We need to remove your notes from our portal.";
                            string Body = "Hello " + noteDetail.User.FirstName + " " + noteDetail.User.LastName + ", \n\nWe want to inform you that, " + noteDetail.Title + " das been removed from the portal.Please find our remarks as below-\n" + noteDetail.Remark + "\n\nRegards,\nNotes Marketplace";
                            mail.Body = Body;

                            SmtpClient smtp = new SmtpClient();
                            smtp.Host = "smtp.gmail.com";
                            smtp.Port = 587;
                            smtp.UseDefaultCredentials = false;

                            NetworkCredential nc = new NetworkCredential(db.SystemConfigurations.FirstOrDefault().EmaillId1, "12345678dummy");
                            smtp.EnableSsl = true;
                            smtp.Credentials = nc;
                            smtp.Send(mail);
                        }
                        catch (Exception)
                        {

                        }
                        return RedirectToAction(view);
                    }
                }
            }
            return HttpNotFound();
        }
        public ActionResult PublishNote(String noteid,String view)
        {
            if (Register_id.id != 0)
            {
                if (noteid != null)
                {
                    NotesDetail noteDetail = db.NotesDetails.FirstOrDefault(m => m.P_K_Note.ToString().Equals(noteid));
                    if (noteDetail != null)
                    {
                        noteDetail.F_K_NoteStatus = 4;
                        noteDetail.ModifiedBy = Register_id.id;
                        noteDetail.PublishedDate = DateTime.Now;
                        db.SaveChanges();
                        return RedirectToAction(view);
                    }
                }
            }
            return HttpNotFound();
        }
        public ActionResult RejectedNote(String noteid, String Remarks,String view)
        {
            if (Register_id.id != 0)
            {
                if (noteid != null)
                {
                    NotesDetail noteDetail = db.NotesDetails.FirstOrDefault(m => m.P_K_Note.ToString().Equals(noteid));
                    if (noteDetail != null)
                    {
                        noteDetail.F_K_NoteStatus = 5;
                        noteDetail.Remark = Remarks;
                        noteDetail.ModifiedBy = Register_id.id;
                        db.SaveChanges();
                        return RedirectToAction(view);
                    }
                }
            }
            return HttpNotFound();
        }
        public ActionResult InReviewNote(String noteid,String view)
        {
            if (Register_id.id != 0)
            {
                if (noteid != null)
                {
                    NotesDetail noteDetail = db.NotesDetails.FirstOrDefault(m => m.P_K_Note.ToString().Equals(noteid));
                    if (noteDetail != null)
                    {
                        noteDetail.F_K_NoteStatus = 2;
                        noteDetail.ModifiedBy = Register_id.id;
                        db.SaveChanges();
                        return RedirectToAction(view);
                    }
                }
            }
            return HttpNotFound();
        }
        public ActionResult DeactivateUser(String id, String view)
        {
            if (Register_id.id != 0)
            {
                if (id != null)
                {
                    User user = db.Users.FirstOrDefault(m => m.P_K_User.ToString().Equals(id));
                    if (user != null)
                    {
                        user.Password2 = user.Password;
                        user.IsActive = false;
                        List<NotesDetail> notes = db.NotesDetails.Where(m => m.F_K_User.ToString().Equals(id)).ToList();
                        if(notes!=null)
                        {
                            foreach(NotesDetail note in notes)
                            {
                                NotesDetail temp = db.NotesDetails.Where(m => m.P_K_Note == note.P_K_Note).FirstOrDefault();
                                temp.IsActive = false;
                                db.SaveChanges();
                            }
                        }
                        db.SaveChanges();
                        return RedirectToAction(view);
                    }
                }
            }
            return HttpNotFound();
        }

        public ActionResult ChangePassword()
        {
            if (Register_id.id != 0)
            {
                return RedirectToAction("ChangePassword", "Home",new { id=Register_id.id});
            }
            return HttpNotFound();
        }
    }
}