package com.opencms.template.cache;
/*
 * File   : $Source: /alkacon/cvs/opencms/src/com/opencms/template/cache/Attic/CmsLruCache.java,v $
 * Date   : $Date: 2001/05/15 10:31:01 $
 * Version: $Revision: 1.2 $
 *
 * Copyright (C) 2000  The OpenCms Group
 *
 * This File is part of OpenCms -
 * the Open Source Content Mananagement System
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * For further information about OpenCms, please see the
 * OpenCms Website: http://www.opencms.com
 *
 * You should have received a copy of the GNU General Public License
 * long with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */


/**
 * This class implements a LRU cache. It uses a Hashtable algorithm with the
 * chaining method for collision handling. The sequence of the Objects is stored in
 * an extra chain. Each object has a pointer to the previous and next object in this
 * chain. If an object is inserted or used it is set to the tail of the chain. If an
 * object has to be remouved it will be the head object.
 *
 * @author
 * @version 1.0
 */

public class CmsLruCache {

    // the array to store everthing
    private CacheItem[] m_cache;

    // the capacity of the cache
    private int m_maxSize;

    // the aktual size of the cache
    private int m_size = 0;

    // the head of the time sequence
    private CacheItem head;

    // the tail of the time sequence
    private CacheItem tail;

    static class CacheItem {
        Object key;
        Object value;

        // the link for the collision hanling
        CacheItem chain;

        // links for the time sequence chain
        CacheItem previous;
        CacheItem next;
    }

    /**
     * Constructor
     * @param size The size of the cache.
     */
    public CmsLruCache(int size) {
//System.err.println("mgm--Cache started with "+size);
        m_cache = new CacheItem[size];
        m_maxSize = size;
    }

    /**
     * inserts a new object in the cache. If it is there already the value is updated.
     * @param key The key to find the object.
     * @param value The object.
     */
    public synchronized void put (Object key, Object value){
        int hashIndex = (key.hashCode() & 0x7FFFFFFF) % m_maxSize;
        CacheItem item = m_cache[hashIndex];
        CacheItem newItem = null;
//System.err.println("mgm--put in cache "+(String)key );
        if(item != null){
            // there is a item allready. Collision.
            // lets look if the new item was inserted before
            while(item.chain != null){
                if(item.key.equals(key)){
                    item.value = value;
                    // TODO: put it to the end of the chain
                    return;
                }
                item = item.chain;
            }
            if(item.key.equals(key)){
                item.value = value;
                //TODO: put it on the end of the chain
                return;
            }
            if(m_size >= m_maxSize){
                // cache full, we have to remove the old head
                CacheItem helper = head.next;
                if (item == head){
                    newItem = item;
                }else{
                    newItem = head;
                    remove(head);
                    newItem.chain = null;
                    item.chain = newItem;
                }
                newItem.next = null;
                head = helper;
                head.previous = null;
            }else{
                m_size++;
                newItem = new CacheItem();
                item.chain = newItem;
            }
        }else{
            // oh goody, a free place for the new item
            if(head != null){
                if(m_size >= m_maxSize){
                    // cache full, we have to remove the old head
                    CacheItem helper = head.next;
                    newItem = head;
                    remove(head);
                    newItem.next = null;
                    newItem.chain = null;
                    head = helper;
                    head.previous = null;
                }else{
                    m_size++;
                    newItem = new CacheItem();
                }
            }else{
                // first item in the chain
                newItem = new CacheItem();
                m_size++;
                head = newItem;
                tail = newItem;
            }
            item = m_cache[hashIndex] = newItem;
        }
        // the new Item is in the array and in the chain. Fill it.
        newItem.key = key;
        newItem.value = value;
        if(tail != newItem){
            tail.next = newItem;
            newItem.previous = tail;
            tail = newItem;
        }
    }

    /**
     * returns the value to the key or null if the key is not in the cache. The found
     * element has to line up behind the others (set to the tail).
     * @param key The key for the object.
     * @return The value.
     */
    public synchronized Object get(Object key){
        int hashIndex = (key.hashCode() & 0x7FFFFFFF) % m_maxSize;
        CacheItem item = m_cache[hashIndex];
//System.err.println("mgm--get from Cache: "+(String)key);
//checkCondition();
        while (item != null){
            if(item.key.equals(key)){
                // got it
                if(item != tail){
                    // hinten anstellen
                    if(item != head){
                        item.previous.next = item.next;
                    }else{
                        head = head.next;
                    }
                    item.next.previous = item.previous;
                    tail.next = item;
                    item.previous = tail;
                    tail = item;
                    tail.next = null;
                }
                return item.value;
            }
            item = item.chain;
        }
//System.err.println("    mgm-- not found in Cache!!!!");
        return null;
    }

    /**
     * deletes one element from the cache.
     * @param oldItem The item to be deleted.
     */
    private void remove(CacheItem oldItem){
//System.err.println("mgm--removing from cache: "+(String)oldItem.key);
        int hashIndex = ((oldItem.key).hashCode() & 0x7FFFFFFF) % m_maxSize;
        CacheItem item = m_cache[hashIndex];
        if(item == oldItem){
            m_cache[hashIndex] = item.chain;
        }else{
            if(item != null){
                while(item.chain != null){
                    if(item.chain == oldItem){
                        item.chain = item.chain.chain;
                        return;
                    }
                    item = item.chain;
                }
            }
        }
    }

    /**
     * used for debuging only. Checks if the Cache is in a valid condition.
     */
    private void checkCondition(){
        System.err.println("");
        System.err.println("mgm-- Verify condition of Cache");
        System.err.println("mgm--size: "+m_size);
        CacheItem item = head;
        int count = 1;
        System.err.println("mgm--");
        System.err.println("mgm--testing content from head to tail:");
        while(item!=null){
            System.err.println("mgm--"+count+". "+(String)item.key);
            count++;
            item=item.next;
        }
        System.err.println("mgm--");
        System.err.println("mgm--now from tail to head:");
        item = tail;
        count--;
        while(item!=null){
            System.err.println("mgm--"+count+". "+(String)item.key);
            count--;
            item=item.previous;
        }
        System.err.println("mgm--now what is realy in cache:");
        count = 1;
        for (int i=0; i<m_maxSize; i++){
            item = m_cache[i];
            System.err.print("    element "+i+" ");
            if(item == null){
                System.err.println(" null");
            }else{
                System.err.println(" count="+count++ +" "+(String)item.key);
                while(item.chain != null){
                    item = item.chain;
                    System.err.println("        chainelement "+" count="+count++ +" "+(String)item.key);
                }
            }
        }
        System.err.println("mgm--test ready!!");
        System.err.println("");

    }
}