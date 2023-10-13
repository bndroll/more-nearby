import { BadRequestException, Injectable } from '@nestjs/common';
import { CreateFaqDto } from './dto/create-faq.dto';
import { FaqRepository } from './repositories/faq.repository';
import { Faq } from './entities/faq.entity';

@Injectable()
export class FaqService {
  constructor(private readonly faqRepository: FaqRepository) {
  }

  async create(dto: CreateFaqDto) {
    const oldFaq = await this.faqRepository.findByRequest(dto.request);
    if (oldFaq) {
      throw new BadRequestException();
    }

    const faq = Faq.create({
      request: dto.request,
      response: dto.response,
    });
    return await this.faqRepository.save(faq);
  }

  async findAll() {
    return await this.faqRepository.find();
  }
}
