Perform a code review between the main branch on this repository and the feature
branch: $ARGUMENTS

Pretend that you are a senior software engineer performing a code review for
correctness, style, maintainability, performance, and code cleanliness. Use the
following checklist to guide your review:

1. Unit test coverage.

- Are there any mistakes or errors in the unit tests added or modified?
- Is there any code added or modified that is missing unit test coverage?
- Are there any unit tests that are not needed or are redundant?
- Are there any refactors to the unit tests that would make them easier to
  read or maintain?

2. Documentation.

- Are there any godoc strings that need to be added or removed?
- Are there any godoc strings with inaccuracies, unclear language, missing
  information, or typos?
- Are there any places where inline comments should be added?
- Is there other documentation that needs to be updated to account for the
  changes, such as a README, a docs directory, or an OpenAPI spec?

3. Typos.

- Are there any typos in the code, comments, or documentation?

4. Code style.

- Are there any style issues that should be fixed?
- Are there any places where the code could be made more readable or
  maintainable?
- Are there any places where the code could be made more performant?

5. Code correctness.

- Are there any bugs in the code?
- Are there any places where the code could be made more robust?
- Are there any places where the code could be made more secure?
- Are there any places where the code could be made more efficient?

6. Code cleanliness.

- Are there any places where the code could be made cleaner or more
  organized?
- Are there any places where the code could be made more modular or reusable?
- Are there any places where the code could be made more idiomatic?
- Are there any places where the code could be made more consistent with the
  rest of the codebase?

7. Dependencies.

- Are there any dependencies that should be added, removed, or updated?
- Are there any dependencies that are not used or are redundant?
- Are there any dependencies that could be replaced with a more suitable
  alternative?
- Are there any dependencies that could be made more efficient or secure?

8. Performance.

- Are there any performance issues that should be addressed?
- Are there any places where the code could be made more efficient?
- Are there any places where the code could be made more performant?
- Are there any places where the code could be made more scalable?

9. Security.

- Are there any security issues that should be addressed?
- Are there any places where the code could be made more secure?
- Are there any places where the code could be made more robust against
  security vulnerabilities?
- Are there any places where the code could be made more resilient against
  attacks?

10. Miscellaneous.

- Are there any other issues that should be addressed?
- Are there any other places where the code could be improved?
- Are there any other places where the code could be made more readable or
  maintainable?
- Are there any other places where the code could be made more performant or
  efficient?
