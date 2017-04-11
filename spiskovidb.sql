SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema spiskovidb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spiskovidb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `spiskovidb` ;

-- -----------------------------------------------------
-- Table `spiskovidb`.`korisnici`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiskovidb`.`korisnici` (
  `id_korisnik` INT NOT NULL AUTO_INCREMENT,
  `korisnicko_ime` VARCHAR(45) NOT NULL,
  `sifra` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_korisnik`),
  UNIQUE INDEX `korisnicko_ime_UNIQUE` (`korisnicko_ime` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spiskovidb`.`proizvodi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiskovidb`.`proizvodi` (
  `id_proizvod` INT NOT NULL AUTO_INCREMENT,
  `naziv` VARCHAR(45) NULL,
  `jedinica_mere` VARCHAR(45) NULL,
  `barkod` VARCHAR(48) NULL,
  PRIMARY KEY (`id_proizvod`),
  UNIQUE INDEX `barkod_UNIQUE` (`barkod` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spiskovidb`.`grupe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiskovidb`.`grupe` (
  `id_grupa` INT NOT NULL,
  `naziv` VARCHAR(45) NULL,
  `grupecol` VARCHAR(45) NULL,
  PRIMARY KEY (`id_grupa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spiskovidb`.`spiskovi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiskovidb`.`spiskovi` (
  `id_spisak` INT NOT NULL AUTO_INCREMENT,
  `naziv` VARCHAR(45) NULL,
  `datum_kreiranja` TIMESTAMP NULL,
  `status` INT NULL DEFAULT 0,
  `datum_promene_statusa` TIMESTAMP NULL,
  `id_grupa` INT NULL,
  `id_korisnik` INT NULL COMMENT 'Korisnik koji je napravio spisak',
  PRIMARY KEY (`id_spisak`),
  INDEX `fk_spiskovi_grupe1_idx` (`id_grupa` ASC),
  INDEX `fk_spiskovi_korisnici1_idx` (`id_korisnik` ASC),
  CONSTRAINT `fk_spiskovi_grupe1`
    FOREIGN KEY (`id_grupa`)
    REFERENCES `spiskovidb`.`grupe` (`id_grupa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_spiskovi_korisnici1`
    FOREIGN KEY (`id_korisnik`)
    REFERENCES `spiskovidb`.`korisnici` (`id_korisnik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spiskovidb`.`proizvodi_spiskovi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiskovidb`.`proizvodi_spiskovi` (
  `id_proizvod` INT NOT NULL,
  `id_spisak` INT NOT NULL,
  `kolicina` DECIMAL(2) NULL,
  `id_korisnik` INT NULL COMMENT 'Id korisnika koji je obavio kupovinu',
  `vreme_kupovine` TIMESTAMP NULL,
  PRIMARY KEY (`id_proizvod`, `id_spisak`),
  INDEX `fk_proizvodi_spiskovi_spiskovi_idx` (`id_spisak` ASC),
  INDEX `fk_proizvodi_spiskovi_korisnici1_idx` (`id_korisnik` ASC),
  CONSTRAINT `fk_proizvodi_spiskovi_spiskovi`
    FOREIGN KEY (`id_spisak`)
    REFERENCES `spiskovidb`.`spiskovi` (`id_spisak`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proizvodi_spiskovi_proizvodi1`
    FOREIGN KEY (`id_proizvod`)
    REFERENCES `spiskovidb`.`proizvodi` (`id_proizvod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proizvodi_spiskovi_korisnici1`
    FOREIGN KEY (`id_korisnik`)
    REFERENCES `spiskovidb`.`korisnici` (`id_korisnik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spiskovidb`.`korisnici_grupe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiskovidb`.`korisnici_grupe` (
  `id_korisnik` INT NOT NULL,
  `id_grupa` INT NOT NULL,
  PRIMARY KEY (`id_korisnik`, `id_grupa`),
  INDEX `fk_korisnici_grupe_grupe1_idx` (`id_grupa` ASC),
  CONSTRAINT `fk_korisnici_grupe_grupe1`
    FOREIGN KEY (`id_grupa`)
    REFERENCES `spiskovidb`.`grupe` (`id_grupa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_korisnici_grupe_korisnici1`
    FOREIGN KEY (`id_korisnik`)
    REFERENCES `spiskovidb`.`korisnici` (`id_korisnik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
