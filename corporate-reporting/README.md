# corporate-reporting

Web parts that provide the user interface for the Online Reporting in BEIS (ORB) service at Department for Business, Energy and Industrial Strategy (BEIS).

## Building the code

Install the latest version of Node.js LTS v12 with npm v6.  

```bash
git clone https://BEIS-DevOps@dev.azure.com/BEIS-DevOps/Corporate%20Reporting/_git/Corporate%20Reporting
cd corporate-reporting
npm i
npm i -g gulp
gulp
```

This package produces the following:

* lib/* - intermediate-stage commonjs build artifacts
* dist/* - the bundled script, along with other resources
* deploy/* - all resources which should be uploaded to a CDN.

## Build options

```
gulp clean                      # Clear dist, lib folders  
npm test                        # Execute unit tests  
gulp serve                      # Build and run solution  
gulp bundle --ship              # Build solution  
gulp package-solution --ship    # Package solution files for deployment  
```

## Release notes

### 6.1.2.0
Bug fix release  
  
#### Bug fixes
[OE-537] Fixed: Error when creating a mitigating action
[OE-539] Fixed: Error deleteing new risk mitigating action with dependent risk
[OE-540] Fixed: Issues to do with risks and mitigating actions in updates. Specifically could only save if there was at least on dependent risk which was wrong.

  
### 6.1.1.0
Bug fix release  
  
#### Bug fixes
[OE-533] Error saving contributors on dir/proj as local admin.  
  
### 6.1.0.0
Minor release adding dependent risks to risk mitigating actions, and showing report headline updates on My Updates to key users and contributors.  

#### Feature updates
[OE-511] Request risk discussion.  
[OE-519] Cross-risk mitigating actions (also [OE-520], [OE-521], [OE-522]).  
[OE-529] Update integration API swagger to include full documentation.  
[OE-530] Reporting Lead/Project Manager/Contributor functionality.  
  
### 6.0.1.0
Bug fix release

#### Bug fixes
[OE-528] Lookup data not loaded on Risks form.  

### 6.0.0.0
Disable management of groups, directorates, projects, partner organisations and users to prevent changes being made by users where the data is managed by an integration system.  

#### Feature updates
[OE-204] Internal integration (disable management of groups, directorates, projects, partner organisations etc where they will be managed by an integration).  
[OE-484] Refactor data lookup feature to be React Hook compatible.  
[OE-489] Risk escalation for decision.  
[OE-493] Clear displayed report if error occurs.  
[OE-498] Refactor provision of data services to components in front-end application.  
[OE-499] Refactor provision of user context to components in front-end application.  
[OE-500] Refactor error handling in front-end application to conform to eslint recommendations.  
[OE-502] Access in Power BI to draft information in ORB.  
[OE-513] Allow projects to be deleted immediately after creation.  
  
#### Bug fixes
[OE-492] Error loading closed custom section lists.  
[OE-507] New project created with same person as SRO and project manager fails validation.  
[OE-512] RMA updates no longer appear in Power BI reports if post-approval risk update is saved.  
[OE-525] Partner Organisation risk mitigating actions not closing (not being hidden from risk assessments).  
  
### 5.0.4.0
Bug fix release  
  
#### Bug fixes
[OE-504] Fix access issues with Microsoft Accounts.  
[OE-505] Benefit current performance required validation not working (OE-509).  
[OE-506] Update form not cleared when moving between periods (OE-510).  
[OE-508] Risk appetite shows as 'To be completed' on risks with approved assessments.  
  
### 5.0.3.0
Bug fix release

#### Bug fixes
[OE-486] Some draft/review and sign-off reports won't load for last period.  
[OE-490] Items in custom sections lists do not load when navigating between custom section lists.  
  
### 5.0.2.0
Bug fix release  
  
#### Bug fixes  
[OE-464] Error when trying to delete a user.  
[OE-469] 'Last period' reports fail to load.  
[OE-470] Duplicate username validation is case sensitive.  
  
### 5.0.1.0
Bug fix release

#### Feature updates
[OE-466] Hide custom report sections when empty.  
  
#### Bug fixes  
[OE-467] ORB crashes when viewing a risk with closed mitigating actions.  

### 5.0.0.0
Major release with new bespoke reporting feature allowing the creation of custom report sections. Migrate SPFx solution to eslint.  

#### Feature updates
[OE-190] Add a maximum character limit to Directorate, Project and Partner Org Objectives field and Risk/Risk mitigating action description.  
[OE-334] Bespoke reporting.  
[OE-363] Show only Partner Organisation report risk section to risk-only users.  
[OE-422] Add Delivery Dates to Dependencies and Dependency Updates to make them consistent with the Milestone date format.  
[OE-425] Make report lists sortable.  
[OE-429] Last approved message on Review & Sign-off.  
[OE-430] In report views, show key work area/work stream that milestones belong to.  
[OE-431] Make forecast delivery date mandatory.  
[OE-433] Make email reminders content more helpful.  
[OE-441] Add attributes to dependencies.  
  
#### Bug fixes
[OE-273] Load Metric and benefit previous RAG from previous metric/benefit update instead of previous report.  
[OE-424] Report 'last edited' times shown in GMT during BST.  
[OE-426] Lead user missing from Benefits on project reports.  
  
### 4.1.0.0

#### Feature updates
[OE-353] Provide RAG trend column in Power BI reports.  
[OE-392] Duplicate 'Last day' at bottom of reporting cycle day of the month dropdown.  
[OE-394] Add constraint to prevent duplicate user groups.  
[OE-409] Start and end date fields for dependencies.  
  
#### Bug fixes
[OE-391] Financial risk owners do not see Review and sign-off on home page.  
[OE-393] 'Unauthorised' error when saving a financial risk with attributes.  
[OE-415] 'Error creating itemundefined' when creating financial risk mitigating action.  
[OE-416] Latest update not loaded in Financial risk register.  
  
### 4.0.3.0  
Bug fix release  
  
#### Bug fixes  
[OE-395] Risks - Error checking if item can be deleted.  
[OE-396] Risk mitigating actions - Error checking if item can be deleted.  
[OE-397] Error creating benefits - Error creating item.  
  
### 4.0.2.0  
Bug fix release
  
#### Bug fixes
[OE-389] Mitigating action validation bug requiring forecast date for ongoing actions.  
  
### 4.0.1.0
Bug fix release

#### Bug fixes
[OE-387] Add Project Attribute columns to report view for backwards compatibility.  
[OE-388] Risks without contributors are filtered out.  
  
### 4.0.0.0
Major release including new Financial Risks feature and SharePoint Framework (SPFx) update including updated UI components.  
Navigation menus have been rearranged.  
  
#### Pre-deployment actions
Copy all project attribute types to attribute types, if one does not already exist with the same name.  

#### Feature updates  
[OE-35] Show which Group/Directorate/Project a risk is associated with in the Risk Register.   
[OE-202] Warn user if they start entering an update very early in the current month.
[OE-232] Validate fortnightly start date for flexible reporting cycles is correct day.  
[OE-247] Add Description field to Commitments and Dependencies.  
[OE-248] Consolidate Project Attributes and Attributes.  
[OE-256] Upgrade to SPFx 1.12.1.  
[OE-272] Display correct previous project RAG in directorate report with different cycle.  
[OE-274] Refactor user permissions loading to improve startup time.  
[OE-293] Financial risks.  
[OE-316] Remove redundant project update fields.  
[OE-327] Make delivery date mandatory on risk mitigating actions.  
[OE-336] Rename Escalations box.  
[OE-356] Add review schedule for ongoing risk mitigating actions.  
[OE-357] On risk register, show 'Ongoing' in delivery date column for ongoing risk mitigating actions.  
[OE-358] On risk register, display next review date for ongoing risk mitigating actions.  
[OE-360] Assign group users to group risk register risks.  
[OE-362] Flag partner organisation users who only need to see risk section of report.  
[OE-369] Add projects to risk register.  

#### Bug fixes  
[OE-347] Incorrect report months in report views (Partner organisations).  
[OE-351] Risk actions not closed when risk is closed by approved sign-off. 
[OE-352] Closed items do not appear in Report Archive on re-approved reports.   
  
### 3.3.0.0
Minor release with email reminders refactored for flexible reporting and other minor feature updates and bug fixes.  
  
#### Feature updates
[OE-223] Update email reminder schedule for flexible reports.  
[OE-234] Filter reports on My Updates by when they are due.  
[OE-270] Add directorate attributes.  
[OE-280] Add first reported date to risks.   

#### Bug fixes
[OE-317] Partner org reports loads obsolete $expands as well as snapshot. Also action RAGs incorrect in back-filled snapshots.

### 3.2.1.0  
Bug fix release  

#### Bug fixes  
[OE-275] "Cannot read property 'WorkStreamUpdates' of undefined" when loading project draft report (with changed work streams).  
  
### 3.2.0.0
Minor release with performance improvements and minor bug fixes. Report snapshots now used in Draft Reports and Sign-off.  

#### Feature updates
[OE-255] Increase all character limits to 500.  
  
#### Bug fixes
[OE-257] Standardise project risk codes. (Convert PRJ codes to PRO).  
[OE-263] User unable to update risk mitigation action despite being down as an owner.  

### 3.1.2.0  
Bug fix release  
  
#### Bug fixes  
[OE-264] Approved risks not appearing in correct month's risk register.  
[OE-265] Closed entities have their closure date overwritten when their parent directorate is closed.  
[OE-266] Directorate reporting cycle copied to project risks.  
  
### 3.1.1.0
Bug fix release  
  
#### Bug fixes  
[OE-258] Error approving project reports.  

### 3.1.0.0  
Minor release adding report snapshots and fixing a number of bugs  
  
#### Feature updates  
[OE-12] Snapshot risk registers and dir/proj/PO reports so they are not affected by closures/changes etc.  
[OE-134] Distribute list columns to better fit the screen.  
[OE-186] Re-calibrate permissions for Risk Admins.  
[OE-241] Back-fill report snapshots.  
  
#### Bug fixes  
[OE-226] Read-only contributor logic on milestones overrides higher-level permissions.  
[OE-229] Delete check on User dirs/projs/roles/pos shows 'null' as item name.  
[OE-238] Error showing closed risks as closed.  
[OE-239] Current RAG missing in review list when dependency is flagged for closure.  
[OE-240] Approvers who are not dir/proj admins cannot approve reports with closed items.  
[OE-244] Baseline dates not showing in Report Archive.  
[OE-245] Cannot create attribute type.  
[OE-249] Update user not set for Partner Org risk updates.  
  
### 3.0.1.0
Bug fix release

#### Bug fixes
[OE-227] Error loading closed milestones in Reporting Admin.  
[OE-228] Show closed commitments in Reporting Admin is reversed.  
[OE-230] Error loading Partner organisations reports in Report Archive.  
[OE-235] Unable to approve DEP and GRP risks.  
[OE-236] Error editing directorate without reporting cycle.  
  
### 3.0.0.0
Major release with new .NET Core API and flexible reporting cycles feature

#### Feature updates
[OE-21] Port API to .NET Core.  
[OE-30] Show target risk rating on draft, sign-off and archive reports.  
[OE-39] Set reporting frequency for each report.  
[OE-162] Add risk IDs to drop down in draft reports.  
[OE-178] Display form errors at top of entity form side panel.  
[OE-184] Remove directorate information from the people icon on risks.  
      
#### Bug fixes
[OE-189] Benefit type is not loaded on Draft Reports/Sign Off/Report Archive benefits lists.  
[OE-221] Error adding attributes to risks as directorate risk admin.  
  
#### Known issues
Risk Register does not load risk updates if the owning directorate's reporting cycle is not calendar monthly.  
Report Archive does not load project updates on directorate reports if the project's reporting cycle does not match the directorate's reporting cycle.  
  
### 2.2.1.0
Bug fix release  
  
#### Bug fixes
[OE-175] SharePoint nav links do not always load in left nav menu.  
[OE-176] Directorate risk admins cannot see risk links in left nav menu.  
[OE-177] Errors do not bubble up and display when they occur on entity forms. E.g. Risks.  
[OE-179] Lookup data does not display in Risk form via old 'CR - Reference Data Admin' web part.  
  
### 2.2.0.0
Sprint 5, 6 release

#### Feature updates
[OE-5] New SPA web part with role-trimmed navigation menu to replace SP menu with multiple pages and web parts.  
[OE-88] Sort entity lists in My Updates and Reports pages alphabetically.  
[OE-136] Allow user accounts to be disabled when no longer required.  
[OE-140] Allow partner organisation records to be closed when no longer required.  
[OE-149] Before allowing deletions, check all entities related by a foreign key constraint, and notify user what they are.  
  
#### Bug fixes
[OE-51] Partner organisation alternate approver not able to save changes to partner organisation risks.  
[OE-53] User can enter 'actual delivery date' in future when updating previous month's report period.  
  
### 2.1.1.0
Bug fix release

#### Bug fixes
[OE-155] Fixed headers on scroll not working.  

### 2.1.0.0
Sprint 4 release

#### Bug fixes
[OE-36] Ensure risks remain in risk register during month in which they are closed.  
[OE-123] Fix data not rendering when scrolling long lists.   
[OE-133] Fix full report printing in Report Archive.  
[OE-145] Reset reporting period when switching to My Updates to prevent earlier month from Risk Register being selected.  
[OE-148] Fix preseting of risk when creating a new risk mitigating action from a newly created risk.  

#### Feature updates
[OE-10] Allow users to edit draft reports in place.  
[OE-14] Prevent users being assigned to entities they cannot access.  
[OE-17] Prevent new risks from appearing in risk register for months before they were created.  
[OE-34] Do not show closed projects, risks etc in Draft Reports.  
[OE-110] Remove edit options from Report Archive, this functionality is now available in Draft Reports.  
[OE-127] Add animations when opening My Updates sections and items.  
[OE-128] Load My Updates people on-demand instead of on page load, to reduce server load.  
[OE-139] Add a Reporting Lead role to directorates and projects.  
[OE-150] Make loading animation behaviour more consistent between homepage tabs.  

### 2.0.4.0
Bug fix release

#### Bug fixes
[OE-137] Risk and risk mitigating action updates not loading into Partner organisation report for sign-off.  
[OE-138] Partner organisation risks lookup not loading in Partner organisation risk mitigating action child form.  
  
### 2.0.3.0
Bug fixes and minor performance improvements    

#### Bug fixes  
[OE-123] Long DetailsLists in report pages do not render more content on scroll.  
[OE-124] Character limit in dependency update form does not match database field size.  
[OE-125] Intermittent measurement unit error on closing benefit form.  
[OE-126] Unable to save changes to work stream (project) milestones.  

#### Feature updates  
[OE-128] Reduce server load from My Updates people details by loading on demand.  
  
### 2.0.2.0
Bug fix release  

#### Bug fixes  
[OE-116] Unable to create entities where attributes and contributors not explicitly dealt with in save routine.  
[OE-119] Prevent infinite loop when error occurs loading lookup data on ref data and system admin pages.  
[OE-120] Milestone updates do not load for users who have no directorate mappings.  
  
### 2.0.1.0
Bug fix release  

#### Bug fix  
[OE-105] Unable to create or edit Work streams with Lead user and/or Contributors.  

#### Feature updates  
[OE-108] Add guidance to report pages to ensure user understands they need to select a report.  

### 2.0.0.0
Oct 2020 release  

Major modernisation and improvements to core code, performance improvements, added unit tests for core components.  
Minor bug fixes.  

#### Feature updates 
[OE-2]	Move Headlines and Risk Assessment contents to My Updates  
[OE-3]	Filter My Updates items  
[OE-6]	Show more associated users for each item  
[OE-7]	Freeze tabs when scrolling  
[OE-8]	Add expand/collapse on content sections  
[OE-15] Add attributes feature to risks  
[OE-22]	Add Benefit realisation date field to Benefits  
[OE-28] Identify risks outside of tolerances  
[OE-42]	Update cr solution to latest SPFx release (v1.11.0)  
[OE-63] Remove risk appetite dropdown field from Risk form  
[OE-64]	Change Draft Reports dropdowns to alphabetical order  
[OE-65]	Group projects in Draft Reports under SoS Priority Projects heading if tagged with that attribute  
[OE-66]	In Draft Reports, show previous month's narrative alongside draft narrative  
[OE-68]	RAG change columns in report view PartnerOrganisationUpdates do not account for different reporting frequencies  
[OE-70]	Add heading for current month's report in Draft Reports when toggle true  
[OE-83]	Make first day of week in date pickers Monday  
[OE-85]	Standardise main header formatting across draft reports, sign-off, report archive  
[OE-87]	Set theme colours to inherit from SharePoint  
[OE-93]	Show number of items in each My Updates section  
[OE-94] Rename Risk description fields  
[OE-99]	Improve report selector layout on Draft Reports  
[OE-101]	Replace all [attributes] with badges  

#### Known issues  
Double-click required to navigate between Reporting Admin and Service Admin pages. Caused by SharePoint navigation bug [#5277](https://github.com/SharePoint/sp-dev-docs/issues/5277) etc.  
Projects list 'Start Date' and 'End Date' columns sort alphabetically, not by date. Caused by DetailsList component bug, where onRender function not called, allowing different sort and display values to be specified. Appears to be fixed somewhere in v7 office-ui-fabric-react.  

### 1.0.0.0
Initial release
