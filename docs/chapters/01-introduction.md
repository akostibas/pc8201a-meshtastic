# Chapter 1: Introduction

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 11-12). Prose is approximate and **tables
> are unreliable** — pending Tier B vision re-OCR. Do not treat
> numeric/tabular values here as authoritative.
> Prose LLM-cleaned 2026-05-29; figures/tables pending Tier B vision re-OCR.

The portable personal computer, PC-8201A is a unique and practical computer. It has many special capabilities in it. For example, it uses large LCD (Liquid Crystal Display), CMOS (Complementary Metal Oxide Semiconductor) technology and special built-in Software.

The built-in software features are very powerful and useful. But for using PC-8201A fully in particular purpose, new Software written in Machine language might be requested. One of the built-in software, N82-BASIC is very useful to make a small utility, but it's not enough to make a large size utility, for instance, Spread Sheet or new Word Processor.

In order to support the programmers who want to make such a large programs, and to support the programmers who want to manage the hardware features directly, this document describes not only the detail hardware features of PC-8201A, but also the know-how to use these features without any trouble.

The most important thing is "compatibility". The built-in Software features keep the promise in using the memory, I/O interface and interrupt functions. The built-in Software checks many critical points at Power-on automatically as far as you don't remove the ROM #0. So if you break the promise, PC-8201A begins "cold start" to initialize the all contents in RAM. In this case, the important files and data which you stored are flushed.

The promise for using PC-8201A's features is described in each chapter. Before making your special program, please refer to the corresponding chapters. The previous INDEX will help you.

The built-in Software uses a small part of the PC-8201A's special features. With this manual, may you make a super programs for your own purpose!!
