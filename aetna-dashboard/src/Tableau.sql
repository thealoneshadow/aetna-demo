  useEffect(() => {
    const newActiveKeys = {};
    const lastIndex = [...data].reverse().findIndex(d => d?.showCollapse);
    const trueIndex = lastIndex === -1 ? -1 : data.length - 1 - lastIndex;

    if (trueIndex !== -1) {
      newActiveKeys[trueIndex] = ['2']; // Open 2nd panel of last valid collapse
    }

    setActiveKeys(newActiveKeys);
  }, [data]);
