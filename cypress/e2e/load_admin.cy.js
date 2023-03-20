describe('admin login', () => {
  it('logs the user into the admin dashboard', () => {

    const username = Cypress.env('ADMINUSERNAME');
    const password = Cypress.env('ADMINPASSWORD');

    cy.visit('https://admin.atomicjolt.xyz/admin');
    cy.get('input[name="user[email]"]').type(username);
    cy.get('input[name="user[password]"]').type(`${password}{enter}`, {log: false});
  });
});
