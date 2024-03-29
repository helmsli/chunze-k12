package com.yoyo.chunze.security.utils;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.StringUtils;

import javax.crypto.Cipher;
import java.math.BigInteger;
import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.RSAPrivateKeySpec;
import java.security.spec.RSAPublicKeySpec;
import java.security.spec.X509EncodedKeySpec;

public class RSAUtils {
	/**
	 * redis key 
	 */
	public static final String Rsa_private_key = "_private_key";
	public static final String Rsa_public_key = "_public_key";
	
	/**
     * 签名算法
     */
	/**
     * 加密算法RSA
     */
    public static final String KEY_ALGORITHM = "RSA";
    
    public static final String SIGNATURE_ALGORITHM = "MD5withRSA";
	/**
	 * transid 中保存的id的长度
	 */
	public static final int Length_ServeridNode=4;
    public static final String RSA_ECB_PKCS1_PADDING = "RSA/ECB/PKCS1Padding";

    public static final int KEY_SIZE_2048 = 2048;
    public static final int KEY_SIZE_1024 = 1024;

    private RSAUtils() {
    }

    private static final String ALGORITHM = "RSA";

    public static KeyPair generateKeyPair() {
        return generateKeyPair(KEY_SIZE_2048);
    }

    public static KeyPair generateKeyPair(int keySize) {
        try {
            KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance(ALGORITHM);
            keyPairGenerator.initialize(keySize);
            return keyPairGenerator.generateKeyPair();
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalArgumentException("Failed to generate key pair!", e);
        }
    }

    public static PublicKey getPublicKey(String base64PublicKey) {
        try {
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(Base64.decodeBase64(base64PublicKey));
            KeyFactory keyFactory = KeyFactory.getInstance(ALGORITHM);
            PublicKey publicKey = keyFactory.generatePublic(keySpec);
            return publicKey;
        } catch (Exception e) {
            throw new IllegalArgumentException("Failed to get public key!", e);
        }
    }

    public static PublicKey getPublicKey(BigInteger modulus, BigInteger exponent) {
        try {
            KeyFactory keyFactory = KeyFactory.getInstance(ALGORITHM);
            RSAPublicKeySpec keySpec = new RSAPublicKeySpec(modulus, exponent);
            return keyFactory.generatePublic(keySpec);
        } catch (Exception e) {
            throw new IllegalArgumentException("Failed to get public key!", e);
        }
    }

    public static String getBase64PublicKey(PublicKey publicKey) {
        return Base64.encodeBase64String(publicKey.getEncoded());
    }

    public static PrivateKey getPrivateKey(String base64PrivateKey) {
        try {
            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(Base64.decodeBase64(base64PrivateKey));
            KeyFactory keyFactory = KeyFactory.getInstance(ALGORITHM);
            PrivateKey privateKey = keyFactory.generatePrivate(keySpec);
            return privateKey;
        } catch (Exception e) {
            throw new IllegalArgumentException("Failed to get private key!", e);
        }
    }

    public static PrivateKey getPrivateKey(BigInteger modulus, BigInteger exponent) {
        try {
            KeyFactory keyFactory = KeyFactory.getInstance(ALGORITHM);
            RSAPrivateKeySpec keySpec = new RSAPrivateKeySpec(modulus, exponent);
            return keyFactory.generatePrivate(keySpec);
        } catch (Exception e) {
            throw new IllegalArgumentException("Failed to get private key!", e);
        }
    }

    public static String getBase64PrivateKey(PrivateKey privateKey) {
        return Base64.encodeBase64String(privateKey.getEncoded());
    }

    public static byte[] encryptAsByteArray(String data, PublicKey publicKey) {
        throwNullPointException(data);
        throwNullPointException(publicKey);
        try {
            Cipher cipher = Cipher.getInstance(RSA_ECB_PKCS1_PADDING);
            cipher.init(Cipher.ENCRYPT_MODE, publicKey);
            return cipher.doFinal(data.getBytes());
        } catch (Exception e) {
            throw new IllegalArgumentException("Encrypt failed!", e);
        }
    }

    public static byte[] encryptAsByteArray(String data, String base64PublicKey) {
        return encryptAsByteArray(data, getPublicKey(base64PublicKey));
    }

    public static String encryptAsString(String data, PublicKey publicKey) {
        return Base64.encodeBase64String(encryptAsByteArray(data, publicKey));
    }

    public static String encryptAsString(String data, String base64PublicKey) {
        return Base64.encodeBase64String(encryptAsByteArray(data, getPublicKey(base64PublicKey)));
    }

    public static String decrypt(byte[] data, PrivateKey privateKey) {
        throwNullPointException(data);
        throwNullPointException(privateKey);
        try {
            Cipher cipher = Cipher.getInstance(RSA_ECB_PKCS1_PADDING);
            cipher.init(Cipher.DECRYPT_MODE, privateKey);
            return new String(cipher.doFinal(data));
        } catch (Exception e) {
            throw new IllegalArgumentException("Decrypt failed!", e);
        }
    }

    public static String decrypt(byte[] data, String base64PrivateKey) {
        return decrypt(data, getPrivateKey(base64PrivateKey));
    }
    /**
     	* 私要签名，公钥校验
     * @param data
     * @param base64PrivateKey
     * @return
     * @throws Exception
     */
    public static String sign(byte[] data, String base64PrivateKey) throws Exception {
    	return sign(data,getPrivateKey(base64PrivateKey));
    }
    public static String sign(String data, String base64PrivateKey) throws Exception {
    	return sign(StringUtils.getBytesUtf8(data),getPrivateKey(base64PrivateKey));
    }
    
    public static String sign(String data, PrivateKey privateKey) {
    	return sign(StringUtils.getBytesUtf8(data),privateKey);
    }
    public static String sign(byte[] data, PrivateKey privateKey)  {
       
        try {
			Signature signature = Signature.getInstance(SIGNATURE_ALGORITHM);
			signature.initSign(privateKey);
			signature.update(data);
			return Base64.encodeBase64String(signature.sign());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return "";
    }
    /**
     * <p>
     * 校验数字签名
     * </p>
     * 
     * @param data 已加密数据
     * @param publicKey 公钥(BASE64编码)
     * @param sign 数字签名
     * 
     * @return
     * @throws Exception
     * 
     */
    public static boolean verify(byte[] data, PublicKey publicKey, String sign)
            {
        try {
			Signature signature = Signature.getInstance(SIGNATURE_ALGORITHM);
			signature.initVerify(publicKey);
			signature.update(data);      
			return signature.verify(Base64.decodeBase64(sign));
		} catch (InvalidKeyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SignatureException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return false;
    }
    
    public static boolean verify(String data, String base64PublicKey, String sign)
    {
    	return verify(StringUtils.getBytesUtf8(data),base64PublicKey,sign);
    }
    public static boolean verify(String data, PublicKey publicKey, String sign)
    {
    	return verify(StringUtils.getBytesUtf8(data),publicKey,sign);
    }
    public static boolean verify(byte[] data, String base64PublicKey, String sign)
    {
    	return verify(data,getPublicKey(base64PublicKey),sign);
    }

    public static String decrypt(String data, PrivateKey privateKey) {
        return decrypt(Base64.decodeBase64(data), privateKey);
    }

    public static String decrypt(String data, String base64PrivateKey) {
        return decrypt(Base64.decodeBase64(data), getPrivateKey(base64PrivateKey));
    }

    private static void throwNullPointException(Object obj) {
        if (null == obj) {
            throw new NullPointerException();
        }
    }
   
}

