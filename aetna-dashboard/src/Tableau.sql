def conversBiDevDb():
    try:
        
        data = request.get_json()
        print(data)

        binaryData = request.get_data()

 
        backend = getBackend()
               
        prompt = data['value']
        history = data['history']
        global table
        table = data['table'] 


        json_str = binaryData.decode('utf-8')
        print(json_str)
        binaryValue = json.loads(json_str)
        print(binaryValue)
        promptMain = binaryValue.get("prompt","")
        print(promptMain)


        print(table)
        global historyList
        historyList = history
        global data_dict_str
        data_dict_str = pd.read_excel("/app/./src/controllers/MMPDNew.xlsx").to_markdown()

        prompt_clari_MMPD = f"""
        {promptMain["mmpdClarification"]}
        """
        print(prompt_clari_MMPD)

        prompt_clari_MC = f"""
            {promptMain["mcClarification"]}
            """
        
        historyList.append({"role":"user","content":prompt})
        # historyList.insert(0, {"role":"user","content":prompt})
        print(historyList)

        prompt1 = build_prompt_with_history(historyList,data_dict_str,prompt_clari_MC,prompt_clari_MMPD)

        result = backend.llm_call(prompt1)
        
       
    except Exception as e:
        print(e)
        return jsonify({'error': 'Internal server error'}), 500
   
   
@module_blueprints.route('/conversational-bi-dev-db', methods=['POST']) # type: ignore
def converse_bi_dev_db():
    result = conversBiDevDb()
    return result




let value = {
 "mmpd:""
 }
  const final = JSON.stringify(value);
        const binary = new TextEncoder().encode(final);

        const responseLog = await axios.post(`${backendDetails.backendUrl}/update-prompt`, { 
            id: "d72e584b-a4e3-4e6d-a0d5-94ecef8b8da6", 
            anem:"Medicare Marketing Performance", 
            value:binary });
        
