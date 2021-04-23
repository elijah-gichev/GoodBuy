using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using GoodBuyAPI.Models;
using Microsoft.AspNetCore.Authorization;
using X.PagedList;

namespace GoodBuyAPI.Controllers
{
    [Authorize]
    public class EntriesController : Controller
    {
        private readonly MyDatabaseContext _context;

        public EntriesController(MyDatabaseContext context)
        {
            _context = context;
        }

        // GET: Entries
        /// <summary>
        /// Main page callback.
        /// </summary>
        /// <param name="sortOrder">/?SortOrder={sortOrder}
        /// Parameter to sort the list
        /// </param>
        /// <param name="currentFilter">/?SortOrder={sortOrder}&currentFilter={filter}
        /// Parameter of search. If you search items and want to sort them, this parameter will be used.
        /// </param> 
        /// <param name="searchString">/?SearchString={searchString}
        /// Parameter to search the list of entries and return matching ones.
        /// </param>
        /// <param name="page">/?page={page}
        /// Page number. By default (on main page) is 1.
        /// </param>
        /// <returns>View of main page.</returns>
        [AllowAnonymous]
        public async Task<IActionResult> Index(string sortOrder, string currentFilter, string searchString, int? page)
        {
            ViewBag.CurrentSort = sortOrder;
            ViewBag.NameSortParam = sortOrder == "Name" ? "name_desc" : "Name";
            ViewBag.DateSortParam = sortOrder == "Date" ? "date_desc" : "Date";
            ViewBag.IdSortParam = String.IsNullOrEmpty(sortOrder) ? "identity_desc" : "";

            if (searchString != null)
            {
                page = 1;
            }
            else
            {
                searchString = currentFilter;
            }

            ViewBag.CurrentFilter = searchString;

            var entries = from s in _context.EntriesList select s;

            if (!String.IsNullOrEmpty(searchString))
            {
                //TODO: Improve searching? Is Contains really good enough?
                entries = entries.Where(s => s.Name.Contains(searchString)
                                             || s.BarcodeId.ToString().Contains(searchString));
            }

            switch (sortOrder)
            {
                case "name":
                    entries = entries.OrderBy(s => s.Name);
                    break;
                case "name_desc":
                    entries = entries.OrderByDescending(s => s.Name);
                    break;
                case "date":
                    entries = entries.OrderBy(s => s.CreatedDate);
                    break;
                case "date_desc":
                    entries = entries.OrderByDescending(s => s.CreatedDate);
                    break;
                case "identity_desc":
                    entries = entries.OrderByDescending(s => s.BarcodeId);
                    break;
                default:
                    entries = entries.OrderBy(s => s.BarcodeId);
                    break;
            }

            int pageSize = Common.PageSize;
            int pageNumber = (page ?? 1);

            return View(await entries.ToPagedListAsync(pageNumber, pageSize));
        }

        #region BeautifulView
        // GET: Entries/Details/5
        //public async Task<IActionResult> Details(ulong? id)
        //{
        //    if (id == null)
        //    {
        //        return NotFound();
        //    }

        //    var entry = await _context.EntriesList
        //        .FirstOrDefaultAsync(m => m.BarcodeId == id);
        //    if (entry == null)
        //    {
        //        return NotFound();
        //    }

        //    return View(entry);
        //}
        #endregion

        // GET: Entries/Details/5
        /// <summary>
        /// Details page. Is used to return a JSON document for API callback.
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [AllowAnonymous]
        public async Task<ActionResult<Entry>> Details(ulong? id)
        {
            var entryItem = await _context.EntriesList.FindAsync(id);
            if (entryItem == null)
            {
                return NotFound();
            }

            return entryItem;
        }

        // GET: Entries/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Entries/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("BarcodeId,Name,Link,CreatedDate")] Entry entry)
        {
            if (ModelState.IsValid)
            {
                _context.Add(entry);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(entry);
        }

        // GET: Entries/Edit/5
        public async Task<IActionResult> Edit(ulong? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var entry = await _context.EntriesList.FindAsync(id);
            if (entry == null)
            {
                return NotFound();
            }
            return View(entry);
        }

        // POST: Entries/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(ulong id, [Bind("BarcodeId,Name,Link,CreatedDate")] Entry entry)
        {
            if (id != entry.BarcodeId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(entry);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!EntryExists(entry.BarcodeId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            return View(entry);
        }

        // GET: Entries/Delete/5
        public async Task<IActionResult> Delete(ulong? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var entry = await _context.EntriesList
                .FirstOrDefaultAsync(m => m.BarcodeId == id);
            if (entry == null)
            {
                return NotFound();
            }
            
            return View(entry);
        }

        // POST: Entries/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(ulong id)
        {
            var entry = await _context.EntriesList.FindAsync(id);
            _context.EntriesList.Remove(entry);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool EntryExists(ulong id)
        {
            return _context.EntriesList.Any(e => e.BarcodeId == id);
        }
    }
}
