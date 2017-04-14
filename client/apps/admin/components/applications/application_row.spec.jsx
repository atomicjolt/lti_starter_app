import React         from 'react';
import TestUtils     from 'react-dom/test-utils';
import { Provider }  from 'react-redux';
import Helper        from '../../../../specs_support/helper';
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

    result = TestUtils.renderIntoDocument(
      <Provider store={Helper.makeStore()}>
        <table><tbody>
          <ApplicationRow {...props} />
        </tbody></table>
      </Provider>
    );

  });

  it('button is clicked', () => {
    const button = TestUtils.findRenderedDOMComponentWithClass(result, 'i-settings');
    TestUtils.Simulate.click(button);
    expect(button).toBeDefined();
  });

  it('renders application instances count', () => {
    const span = TestUtils.findRenderedDOMComponentWithTag(result, 'span');
    expect(span.textContent).toContain('123');
  });

  it('renders application link', () => {
    const linkTag = TestUtils.findRenderedDOMComponentWithTag(result, 'a');
    expect(linkTag.innerText).toContain('SPECNAME');
  });

});
