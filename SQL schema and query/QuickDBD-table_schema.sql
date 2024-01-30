-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/UmUvHL
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "card_holder" (
    "cardholder_id" int   NOT NULL,
    "mame_of_cardholder" charactervarying(30)   NOT NULL,
    CONSTRAINT "pk_card_holder" PRIMARY KEY (
        "cardholder_id"
     )
);

CREATE TABLE "credit_card" (
    "card_number" varchar(20)   NOT NULL,
    "cardholder_id" int   NOT NULL
);

CREATE TABLE "merchant_category" (
    "merchant_category_id" int   NOT NULL,
    "merchant_category_name" charactervarying(30)   NOT NULL
);

CREATE TABLE "merchant" (
    "merchant_id" int   NOT NULL,
    "merchant_name" charactervarying(30)   NOT NULL,
    "merchant_category_id" int   NOT NULL
);

CREATE TABLE "transaction" (
    "transaction_Id" int   NOT NULL,
    "date" timestamp   NOT NULL,
    "amount" numeric(5.2)   NOT NULL,
    "card_number" varchar(20)   NOT NULL,
    "merchant_id" int   NOT NULL
);

ALTER TABLE "card_holder" ADD CONSTRAINT "fk_card_holder_cardholder_id" FOREIGN KEY("cardholder_id")
REFERENCES "credit_card" ("cardholder_id");

ALTER TABLE "credit_card" ADD CONSTRAINT "fk_credit_card_card_number" FOREIGN KEY("card_number")
REFERENCES "transaction" ("card_number");

ALTER TABLE "merchant_category" ADD CONSTRAINT "fk_merchant_category_merchant_category_id" FOREIGN KEY("merchant_category_id")
REFERENCES "merchant" ("merchant_category_id");

ALTER TABLE "merchant" ADD CONSTRAINT "fk_merchant_merchant_id" FOREIGN KEY("merchant_id")
REFERENCES "transaction" ("merchant_id");

