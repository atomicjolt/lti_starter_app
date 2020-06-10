import React from 'react';
import { shallow } from 'enzyme';
import ListRow from './list_row';

describe('application instances list row', () => {
  let props;
  let result;
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
    result = shallow(<ListRow {...props} />);
  });

  // the following tests will break if the order of the buttons is changed
  // to remedy this a class would need to be added to each button

  it('handles the opening of the modal', () => {
    expect(result.instance().state.modalOpen).toBeFalsy();
    const btn = result.find('button').first();
    btn.simulate('click');
    expect(result.instance().state.modalOpen).toBeTruthy();
  });

  it('handles deleting', () => {
    expect(deleted).toBeFalsy();
    expect(result.instance().state.confirmDeleteModalOpen).toBeFalsy();
    const btn = result.find('button').last();
    btn.simulate('click');
    expect(result.instance().state.confirmDeleteModalOpen).toBeTruthy();
  });
});
