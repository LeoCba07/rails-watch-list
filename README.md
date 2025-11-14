# README

# 🎬 Rails Watch List

A Ruby on Rails application for creating and managing movie watchlists.

## Setup
```bash
bundle install
rails db:create db:migrate db:seed
rails server
```

Visit `http://localhost:3000`

## Features

- Create custom movie lists
- Add movies to your watchlists
- Add reviews and comments
- Browse and manage your collections

## Tech Stack

- Ruby on Rails
- PostgreSQL
- Bootstrap
- Active Storage

## Database

- **List**: has many movies through bookmarks
- **Movie**: has many lists through bookmarks
- **Bookmark**: joins lists and movies

---

Built with ❤️ by [LeoCba07](https://github.com/LeoCba07)
