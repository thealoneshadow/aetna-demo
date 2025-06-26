.popup-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.4);
  display: flex;
  justify-content: center;
  align-items: center;
}

.popup-content {
  background: white;
  padding: 20px;
  border-radius: 8px;
  max-height: 90vh;
  max-width: 95vw;
  overflow: auto; /* important for scroll if table/chart is too big */
  box-shadow: 0 2px 10px rgba(0,0,0,0.3);
}
