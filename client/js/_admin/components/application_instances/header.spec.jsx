import React     from 'react';
import TestUtils from 'react-addons-test-utils';
import Stub      from '../../../../specs_support/stub';
import Header    from './header';

describe('application instances header', () => {

  let result;
  const props = {
    application: {
      name: 'test application',
    },
    newApplicationInstance: () => {},
  };

  beforeEach(() => {
    result = TestUtils.renderIntoDocument(
      <Stub>
        <Header {...props} />
      </Stub>
    );
  });

  it('renders the header with the app name', () => {
    const h1 =  TestUtils.findRenderedDOMComponentWithTag(result, 'h1');
    expect(h1.textContent).toContain(props.application.name);
  });

  it('renders new application instance button', () => {
    const button =  TestUtils.findRenderedDOMComponentWithTag(result, 'button');
    expect(button.textContent).toBe('New Application Instance');
  });

});
