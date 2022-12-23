describe('empty spec', () => {
  it('passes', () => {

    const username = Cypress.env('USERNAME');
    const password = Cypress.env('PASSWORD');

    cy.visit('atomicjolt.instructure.com');
    cy.get('input[name="pseudonym_session[unique_id]"]').type(username);
    cy.get('input[name="pseudonym_session[password]"]').type(`${password}{enter}`, {log: false});
  })
})