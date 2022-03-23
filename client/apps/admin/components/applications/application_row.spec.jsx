import React from 'react';
import TestRenderer from 'react-test-renderer';
import ApplicationRow from './application_row';

describe('applications application row', () => {
  let result;
  let props;

  beforeEach(() => {
    props = {
      application: {
        id                          : 314159,
        name                        : 'SPECNAME',
        application_instances_count : 1234
      },
      saveApplication: () => {}
    };

    result = TestRenderer.create(<ApplicationRow {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('button is clicked', () => {
    expect(result.root.state.modalOpen).toBeFalsy();
    instance.findByType('button').props.onClick();
    expect(result.root.state.modalOpen).toBeTruthy();
  });
});
