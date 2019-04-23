﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using kore_api.koredb;
using kore_api.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace kore_api.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class AccountsController : Controller
    {
        private readonly IAccountsRepository _accountsRepository;

        public AccountsController(IAccountsRepository accountsRepository)
        {
            _accountsRepository = accountsRepository;
        }

        // GET: api/accounts
        [HttpGet]
        public IEnumerable<Account> GetAll()
        {
            return _accountsRepository.GetAccounts();
        }

        // GET: api/accounts/id
        [HttpGet("{id}")]
        public Account Get(int id)
        {
            return _accountsRepository.GetAccount(id);
        }

        // POST: api/accounts/id
        // updates the status and date modified rows
        [HttpPost("{id}")]
        public bool UpdateAccount(int id, [FromBody] int status)
        {
            return _accountsRepository.UpdateAccount(id, status);
        }
    }
}