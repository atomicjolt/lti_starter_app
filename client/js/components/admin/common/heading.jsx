import React        from 'react';
import assets       from '../../../libs/assets';

const Heading = () => {
  const img = assets('./images/atomicjolt.svg');
  const styles = {
    bar: {
      background: 'black',
      height: '50px',
      borderBottom: 'solid #EFC210 1px',
      display: 'block',
    },
    h1: {
      textAlign: 'center',
      color: '#EFC210',
      paddingTop: '5px',
      paddingLeft: '20px',
    },
    color: {
      float: 'right',
      paddingTop: '10px',
      paddingRight: '20px',
      color: 'lightgrey',
      fontFamily: 'Roboto, sans-serif',
    }
  };

  return (
    <div style={styles.bar}>
      <h1 style={styles.h1}>
        <img src={img} alt="AtomicJolt Logo" height="40px" />
        <div style={styles.color}>
          pronto
        </div>
      </h1>
    </div>
  );
};

export default Heading;
