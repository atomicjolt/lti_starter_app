import React from 'react';
import { shallow } from 'enzyme';
import ApplicationRow from './application_row';

describe('applications application row', () => {
  let result;
  let props;

  beforeEach(() => {
    props = {
      application: {
        id                          : 314159,
        name                        : 'SPECNAME',
        application_instances_count : 123
      },
      saveApplication: () => {}
    };

    result = shallow(<ApplicationRow {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('button is clicked', () => {
    expect(result.instance().state.modalOpen).toBeFalsy();
    result.find('button').simulate('click');
    expect(result.instance().state.modalOpen).toBeTruthy();
  });
});
