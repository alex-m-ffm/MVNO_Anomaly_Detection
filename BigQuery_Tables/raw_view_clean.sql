  SELECT DATETIME(TIMESTAMP_MILLIS(CAST (Ts AS INT64)), 'Europe/Berlin') AS Ts,
      userID, CAST(bytesSent AS NUMERIC) AS bytesSent, CAST(bytesReceived AS NUMERIC) AS bytesReceived, CAST(bytesReceivedProxy AS NUMERIC) AS bytesReceivedProxy, hostFull, 
      split(hostFull, '.')[ORDINAL(1)] AS host1, 
      split(hostFull, '.')[ORDINAL(2)] AS host2, 
      isHTTPS, CL_RTT, OS_RTT, CL_Retrans, OS_Retrans, OS_Transmit_time_noSubstract, CL_Transmit_time_noSubstract, 
      OS_Transmit_time, CL_Transmit_time, 
      CASE WHEN CL_Transmit_time_noSubstract - CL_Transmit_time >= 0 THEN CL_Transmit_time_noSubstract - CL_Transmit_time END AS CL_inactive_time,
      CASE WHEN OS_Transmit_time_noSubstract - OS_Transmit_time >= 0 THEN OS_Transmit_time_noSubstract - OS_Transmit_time END AS OS_inactive_time,
      CAST(bytesReceived / 1024 / CL_Transmit_time * 1000 AS NUMERIC) AS download_speed_CL_clean,
      CAST(bytesReceived / 1024 / CL_Transmit_time_noSubstract * 1000 AS NUMERIC) AS download_speed_CL_raw,
      CAST(bytesSent / 1024 / CL_Transmit_time * 1000 AS NUMERIC) AS upload_speed_CL_clean,
      CAST(bytesSent / 1024 / CL_Transmit_time_noSubstract * 1000 AS NUMERIC) AS upload_speed_CL_raw,
      CAST(bytesReceivedProxy/ 1024 / OS_Transmit_time * 1000 AS NUMERIC) AS download_speed_OS_clean,
      CAST(bytesReceivedProxy / 1024 / OS_Transmit_time_noSubstract * 1000 AS NUMERIC) AS download_speed_OS_raw,
      CAST(bytesSent / 1024 / OS_Transmit_time * 1000 AS NUMERIC) AS upload_speed_OS_clean,
      CAST(bytesSent / 1024 / OS_Transmit_time_noSubstract * 1000 AS NUMERIC) AS upload_speed_OS_raw,
      EXTRACT(HOUR FROM TIMESTAMP_MILLIS(CAST (Ts AS INT64)) AT TIME ZONE 'Europe/Berlin') AS hour
    FROM `case-study-2-nec-team.logs.raw`
      WHERE CL_RTT > 0 AND OS_RTT > 0 AND CL_Retrans >= 0 AND OS_Retrans >= 0 AND OS_Transmit_time_noSubstract > 0 AND CL_Transmit_time_noSubstract > 0 AND OS_Transmit_time > 0 AND CL_Transmit_time > 0