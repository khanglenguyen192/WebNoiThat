using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using WebBanNoiThat.Models;

namespace WebBanNoiThat.Controllers
{
    public class SanPhamController : Controller
    {
        private readonly BanNoiThatContext _context;

        public SanPhamController(BanNoiThatContext context)
        {
            _context = context;
        }


        public async Task<IActionResult> Index()
        {
            var hiepBaoComputerContext = _context.SanPhams.Include(s => s.MaDmNavigation);
            return View(await hiepBaoComputerContext.ToListAsync());
        }

        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var sanPham = await _context.SanPhams
                .Include(s => s.MaDmNavigation)
                .FirstOrDefaultAsync(m => m.MaSp == id);
            if (sanPham == null)
            {
                return NotFound();
            }

            return View(sanPham);
        }

  
    }
}
