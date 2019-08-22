import Enzyme from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import ReactModal from 'react-modal';

// Configure Enzyme
Enzyme.configure({ adapter: new Adapter() });

// Eliminate ReactModal warnings in tests
ReactModal.setAppElement(document.createElement('div'));
