-- DB update 2021_10_14_10 -> 2021_10_14_11
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_14_10';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_14_10 2021_10_14_11 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634130719161646149'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634130719161646149');

-- Delete Plans: Corruption from various NPCs
DELETE FROM `creature_loot_template` WHERE `Entry` IN (10398, 10399, 10400, 10406, 10407, 10408, 10409, 10412, 10413, 10463, 10464) AND `Item` = 12830;

-- Delete Plans: Corruption from RLT 24709
DELETE FROM `reference_loot_template` WHERE `Entry` = 24709 AND `Item` = 12830;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_14_11' WHERE sql_rev = '1634130719161646149';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;