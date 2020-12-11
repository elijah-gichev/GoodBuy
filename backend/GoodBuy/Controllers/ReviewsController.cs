using GoodBuy.Models;
using GoodBuy.Services;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace GoodBuy.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReviewsController : ControllerBase
    {
        private readonly ReviewsService _reviewsService;

        public ReviewsController(ReviewsService reviewService)
        {
            _reviewsService = reviewService;
        }
        /// <summary>
        /// /api/reviews get all.
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult<List<Review>> Get() =>
            _reviewsService.Get();

        /// <summary>
        /// /api/reviews/{QrCode} get.
        /// </summary>
        /// <param name="qrCode"></param>
        /// <returns></returns>
        [HttpGet("{QrCode}", Name = "GetReview")]
        public ActionResult<Review> Get(string qrCode)
        {
            var review = _reviewsService.Get(qrCode);

            if (review == null)
            {
                return NotFound();
            }

            return Ok(review);
        }
        #region DangerousOperations
        /// <summary>
        /// Creates a new entry in database. Will be used to create add new review pages.
        /// todo: PUT IT BEHIND AN AUTHENTICATION.
        /// </summary>
        /// <param name="review"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult<Review> Create(Review review)
        {
            _reviewsService.Create(review);

            return CreatedAtRoute("GetReview", new { id = review.Id.ToString() }, review);
        }
        /// <summary>
        /// Updates existing entry. Will be used to update faulty entries.
        /// todo: PUT IT BEHIND AN AUTHENTICATION.
        /// </summary>
        /// <param name="id"></param>
        /// <param name="reviewIn"></param>
        /// <returns></returns>
        [HttpPut("{id:length(24)}")]
        public IActionResult Update(string id, Review reviewIn)
        {
            var review = _reviewsService.Get(id);

            if (review == null)
            {
                return NotFound();
            }

            _reviewsService.Update(id, reviewIn);

            return NoContent();
        }
        /// <summary>
        /// Deletes an entry. Self explanatory.
        /// todo: PUT IT BEHIND AN AUTHENTICATION. 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpDelete("{id:length(24)}")]
        public IActionResult Delete(string id)
        {
            var review = _reviewsService.Get(id);

            if (review == null)
            {
                return NotFound();
            }

            _reviewsService.Remove(review.Id);

            return NoContent();
        }
        #endregion
    }
}
