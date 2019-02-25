function annotstruct2xml(testStruct)
    index = 1;
    list_tools = {'grasper' 'maryland' 'electrocautery' 'scissors' 'suction' 'unidentified'};
    
    while index <= length(testStruct)
        % Create a Document Object Module
        docNode = com.mathworks.xml.XMLUtils.createDocument('annotation');
        docRootNode = docNode.getDocumentElement;

        folder_node = docNode.createElement('folder');
        folder_text = docNode.createTextNode('VOC2007');
        folder_node.appendChild(folder_text);
        docRootNode.appendChild(folder_node);

        filename_node = docNode.createElement('filename');
        fname = testStruct(index).frame;
        filename_text = docNode.createTextNode(fname);
        filename_node.appendChild(filename_text);
        docRootNode.appendChild(filename_node);
        
        source_node = docNode.createElement('source');
            database_node = docNode.createElement('database');
            database_text = docNode.createTextNode('0');
            database_node.appendChild(database_text);
            source_node.appendChild(database_node);
            
            annotation_node = docNode.createElement('annotation');
            annotation_text = docNode.createTextNode('0');
            annotation_node.appendChild(annotation_text);
            source_node.appendChild(annotation_node);
            
            image_node = docNode.createElement('image');
            image_text = docNode.createTextNode('0');
            image_node.appendChild(image_text);
            source_node.appendChild(image_node);
            
            flickrid1_node = docNode.createElement('flickrid');
            flickrid1_text = docNode.createTextNode('0');
            flickrid1_node.appendChild(flickrid1_text);
            source_node.appendChild(flickrid1_node);
        docRootNode.appendChild(source_node);
        
        owner_node = docNode.createElement('owner');
            flickrid2_node = docNode.createElement('flickrid');
            flickrid2_text = docNode.createTextNode('0');
            flickrid2_node.appendChild(flickrid2_text);
            owner_node.appendChild(flickrid2_node);
            
            name1_node = docNode.createElement('name');
            name1_text = docNode.createTextNode('0');
            name1_node.appendChild(name1_text);
            owner_node.appendChild(name1_node);
        docRootNode.appendChild(owner_node);
        
        size_node = docNode.createElement('size');
            width_node = docNode.createElement('width');
            width_text = docNode.createTextNode(int2str(testStruct(index).size(1)));
            width_node.appendChild(width_text);
            size_node.appendChild(width_node);
            
            height_node = docNode.createElement('height');
            height_text = docNode.createTextNode(int2str(testStruct(index).size(2)));
            height_node.appendChild(height_text);
            size_node.appendChild(height_node);
            
            depth_node = docNode.createElement('depth');
            depth_text = docNode.createTextNode(int2str(testStruct(index).size(3)));
            depth_node.appendChild(depth_text);
            size_node.appendChild(depth_node);
        docRootNode.appendChild(size_node);
        
        segmented_node = docNode.createElement('segmented');
        segmented_text = docNode.createTextNode('0');
        segmented_node.appendChild(segmented_text);
        docRootNode.appendChild(segmented_node);
        
        sameframe = true;
        while (index <= length(testStruct)) && sameframe    
            object_node = docNode.createElement('object');
                name2_node = docNode.createElement('name');
                if (testStruct(index).class) == 0
                    name2_text = docNode.createTextNode('background');
                else
                    name2_text = docNode.createTextNode(list_tools(testStruct(index).class));
                end
                name2_node.appendChild(name2_text);
                object_node.appendChild(name2_node);

                pose_node = docNode.createElement('pose');
                pose_text = docNode.createTextNode('Unspecified');
                pose_node.appendChild(pose_text);
                object_node.appendChild(pose_node);

                truncated_node = docNode.createElement('truncated');
                truncated_text = docNode.createTextNode('0');
                truncated_node.appendChild(truncated_text);
                object_node.appendChild(truncated_node);

                difficult_node = docNode.createElement('difficult');
                difficult_text = docNode.createTextNode('0');
                difficult_node.appendChild(difficult_text);
                object_node.appendChild(difficult_node);

                bndbox_node = docNode.createElement('bndbox');
                    xmin_node = docNode.createElement('xmin');
                    xmin_text = docNode.createTextNode(int2str(testStruct(index).coord(1)));
                    xmin_node.appendChild(xmin_text);
                    bndbox_node.appendChild(xmin_node);

                    ymin_node = docNode.createElement('ymin');
                    ymin_text = docNode.createTextNode(int2str(testStruct(index).coord(2)));
                    ymin_node.appendChild(ymin_text);
                    bndbox_node.appendChild(ymin_node);

                    xmax_node = docNode.createElement('xmax');
                    xmax_text = docNode.createTextNode(int2str(testStruct(index).coord(3)));
                    xmax_node.appendChild(xmax_text);
                    bndbox_node.appendChild(xmax_node);

                    ymax_node = docNode.createElement('ymax');
                    ymax_text = docNode.createTextNode(int2str(testStruct(index).coord(4)));
                    ymax_node.appendChild(ymax_text);
                    bndbox_node.appendChild(ymax_node);
                object_node.appendChild(bndbox_node);
            docRootNode.appendChild(object_node);
            if (index < length(testStruct)) && strcmp(fname, testStruct(index+1).frame)
                index = index + 1;
            else
                sameframe = false;
            end
        end

        dir = '/Users/AmyJin/Documents/ComputerVisionProject/Surgical Video Analysis/VOCdevkit/VOC2007/Annotations/';
        xmlFileName = strcat(fname(1:end-4), '.xml'); % remove .jpg from fname and append .xml
        xmlwrite(strcat(dir, xmlFileName), docNode);
        
        index = index + 1;
   end
end