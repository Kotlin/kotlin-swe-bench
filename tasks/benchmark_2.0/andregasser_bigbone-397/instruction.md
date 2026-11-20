Implement Admin Domain Blocks API
Mastodon's Admin Domain Blocks API allows an admin to disallow certain domains to federate. The goal of this task is to implement the following endpoints of this API in BigBone:

- List all blocked domains
- Get a single blocked domain
- Block a domain from federating
- Update a domain block
- Remove a domain block

The Admin Domain Blocks API as it is documented by Mastodon can be found here:
https://docs.joinmastodon.org/methods/admin/domain_blocks/

Tip: A lot of other endpoints similar to this have already been implemented. In order to get an idea how to implement this, I suggest that you study the code upfront. Start with one of the `*Methods.kt` files.

Please consult the following documents to make sure your contribution meets our projects criteria:

- [Code of Conduct](https://github.com/andregasser/bigbone/blob/master/CODE_OF_CONDUCT.md)
- [Code Contribution Guidelines](https://github.com/andregasser/bigbone/blob/master/CONTRIBUTING.md)

## Interface

The tests use these declarations:

- `social.bigbone.api.entity.admin.AdminDomainBlock` — class with `id: String`, `domain: String`, `createdAt: PrecisionDateTime`, `severity: Severity`, `rejectMedia: Boolean`, `rejectReports: Boolean`, `obfuscate: Boolean`, `privateComment: String?`, `publicComment: String?`, and nested `enum class Severity` with `NOOP` and `SUSPEND`
- `social.bigbone.api.method.admin.AdminDomainBlockMethods(MastodonClient)` with:
  - `getAllBlockedDomains(range: Range = …): MastodonRequest<Pageable<AdminDomainBlock>>`
  - `getBlockedDomain(id: String): MastodonRequest<AdminDomainBlock>`
  - `blockDomain(domain: String, severity: Severity?, rejectMedia: Boolean?, rejectReports: Boolean?, obfuscate: Boolean?, privateComment: String?, publicComment: String?): MastodonRequest<AdminDomainBlock>`
  - `updateBlockedDomain(id: String, severity: Severity?, …)`: same remaining parameters and return type as `blockDomain`, those after `severity` with defaults
  - `removeBlockedDomain(id: String)`

## Requirements

- The requests are sent to `api/v1/admin/domain_blocks` with no leading slash; the methods that take an `id` use `api/v1/admin/domain_blocks/<id>`
