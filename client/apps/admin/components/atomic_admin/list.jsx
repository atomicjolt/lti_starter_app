import React, {useState} from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import DeleteModal from '../common/delete_modal';

import Modal from './modal';

const getStyles = () => ({
  buttonIcon: {
    border: 'none',
    backgroundColor: 'transparent',
    color: 'grey',
    fontSize: '1.5em',
    cursor: 'pointer',
  },
  alertStyle: {
    fontSize: '10px'
  }
});

export default function List(props) {
  const {
    fields,
    formType,
    elements,
    emptyText,
    createElement,
    saveElement,
    deleteElement
    // deleteSite,
  } = props;

  const [editModalOpen, setEditModalOpen] = useState(false);
  const [selectedElement, setSelectedElement] = useState({});
  const [deleteModalOpen, setDeleteModalOpen] = useState(false);

  const styles = getStyles();
  const rows = _.map(elements, (e, i) => {

    const openModal = () => {
      setEditModalOpen(true)
      setSelectedElement(e)
    }

  const summaryFields = _.chain(fields).filter(e => e.showInSummary)
  .map(f => e[f.prop])
  .map(value => <td> {value} </td>)
  .value()

    return (
    <tr>
      {summaryFields}
      <td>
        <button
          type="button"
          style={styles.buttonIcon}
          onClick={openModal}
        >
          <i className="material-icons">settings</i>
        </button>
        {
          selectedElement ? <Modal
          key={`${formType}_${selectedElement.id}`}
          isOpen={editModalOpen}
          closeModal={() => setEditModalOpen(false)}
          fields={fields}
          selectedElement={selectedElement}
          saveElement={(formData) => saveElement(selectedElement.id, formData)}
          createElement={createElement}
        /> : null
        }

      </td>
      <td>
        <button
          type="button"
          style={styles.buttonIcon}
          onClick={() => setDeleteModalOpen(true)}
        >
          <i className="i-delete" />
        </button>
        <DeleteModal
          deleteRecord={() => {deleteElement(e.id)}}
          isOpen={deleteModalOpen}
          closeModal={() => setDeleteModalOpen(false)}
        />
      </td>
    </tr>
  )
  })

  if (_.isEmpty(elements)) {
    return <p className="c-alert c-alert--danger">{emptyText}</p>;
  }

  const columns = _.chain(fields).filter(e => e.showInSummary).map(e => e.label)
    .map(e => { 
      return <th><span>{_.toUpper(e)}</span></th>
    })
    .value()

  return (
    <table className="c-table c-table--lti">
      <thead>
        <tr>
          {columns}
          <th><span>SETTINGS</span></th>
          <th><span>DELETE</span></th>
        </tr>
      </thead>
      <tbody>
        {rows}
      </tbody>
    </table>
  );
}

// List.propTypes = {
//   sites: PropTypes.shape({}).isRequired,
//   deleteSite: PropTypes.func.isRequired,
// };
