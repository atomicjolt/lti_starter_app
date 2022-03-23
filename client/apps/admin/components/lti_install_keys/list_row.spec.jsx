import React from 'react';
import TestRenderer from 'react-test-renderer';
import ListRow from './list_row';

describe('application instances list row', () => {
  let props;
  let result;
  let instance;
  let deleted;

  beforeEach(() => {
    deleted = false;
    props = {
      delete: () => { deleted = true; },
      save: () => {},
      ltiInstallKey: {
        id: 2,
        application_id: 23,
        clientId: 'lti-key',
        iss: 'iss',
        jwksUrl: 'jwksUrl',
        tokenUrl: 'tokenUrl',
        oidcUrl: 'oidcUrl',
        created_at: 'created_at',
      },
    };
    result = TestRenderer.create(<ListRow {...props} />);
    instance = result.root;
  });

  // the following tests will break if the order of the buttons is changed
  // to remedy this a class would need to be added to each button

  it('handles the opening of the modal', () => {
    expect(instance.state.modalOpen).toBeFalsy();
    const btn = instance.findByType('button').first();
    btn.props.onClick();
    expect(result.root.state.modalOpen).toBeTruthy();
  });

  it('handles deleting', () => {
    expect(deleted).toBeFalsy();
    expect(instance.state.confirmDeleteModalOpen).toBeFalsy();
    const btn = instance.findByType('button').last();
    btn.props.onClick();
    expect(result.root.state.confirmDeleteModalOpen).toBeTruthy();
  });
});
